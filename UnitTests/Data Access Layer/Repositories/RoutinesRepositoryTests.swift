//
//  RoutinesRepositoryTests.swift
//  UnitTests
//
//  Description:
//
//  Created by Dominic Danborn on 3/1/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import Combine
@testable import Lift_Tracker

class RoutinesRepositoryTests: XCTestCase {
    
    var systemUnderTest: RealRoutinesRepository!
    
    var mockedStore: MockedPersistentStore!
    
    var cancelBag = CancelBag()
    
    override func setUp() {
        super.setUp()
        mockedStore = MockedPersistentStore()
        systemUnderTest = RealRoutinesRepository(persistentStore: mockedStore)
        mockedStore.verify()
    }
    
    override func tearDown() {
        cancelBag = CancelBag()
        systemUnderTest = nil
        mockedStore = nil
        super.tearDown()
    }
    
    // Test creating a new routine
    func test_createRoutine() {
        let routine = RoutineStruct(id: UUID(), routineName: "Test Routine", exercises: [])
        mockedStore.actions = .init(expected: [.update()])
        let expectation = XCTestExpectation(description: "createRoutine completes")
        systemUnderTest.createRoutine(routine: routine)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { })
            .store(in: cancelBag)
        wait(for: [expectation], timeout: 1.0)
        mockedStore.verify()
    }
    
    /// Test for verifying the `readRoutines` method of `RealRoutinesRepository`.
    /// Ensures that the method fetches routines correctly from the persistent store and returns them as expected.
    func test_readRoutines() throws {
        // Setup mock data and expectations
        let expectedRoutines = RoutineStruct.testData
        mockedStore.actions = .init(expected: [
            .fetch(.init(inserted: 0, updated: 0, deleted: 0))
        ])
        try mockedStore.preloadData { context in
            expectedRoutines.forEach { $0.store(in: context) }
        }
        
        // XCTest expectation to wait for asynchronous code
        let expected = XCTestExpectation(description: #function)
        
        // Execute the test
        systemUnderTest.readRoutines()
            .sinkToResult { result in
                // Assert the result matches expected data
                result.assertSuccess(value: expectedRoutines)
                // Verify mock store interactions
                self.mockedStore.verify()
                // Verify mock store interactions
                expected.fulfill()
            }
            .store(in: cancelBag)
        // Wait for the test to complete
        wait(for: [expected], timeout: 0.5)
    }
    
    // Test updating a routine
    func test_updateRoutine() {
        let routine = RoutineStruct(id: UUID(), routineName: "Updated Routine", exercises: [])
        mockedStore.actions = .init(expected: [.update])
        let expectation = XCTestExpectation(description: "updateRoutine completes")
        systemUnderTest.updateRoutine(routine: routine)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { })
            .store(in: cancelBag)
        wait(for: [expectation], timeout: 1.0)
        mockedStore.verify()
    }
    
    // Test deleting a routine
    func test_deleteRoutine() {
        let routine = RoutineStruct(id: UUID(), routineName: "Routine to Delete", exercises: [])
        mockedStore.actions = .init(expected: [.update])
        let expectation = XCTestExpectation(description: "deleteRoutine completes")
        systemUnderTest.deleteRoutine(routine: routine)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { })
            .store(in: cancelBag)
        wait(for: [expectation], timeout: 1.0)
        mockedStore.verify()
    }
}
