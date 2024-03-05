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
    
    /// Test for verifying the `createRoutine` method of `RealRoutinesRepository`.
    /// Ensures that the method creates a routine successfully in the persistent store.
    func test_createRoutine() {
        // Select a routine to test creation.
        let routineToCreate = RoutineStruct.testData[0]
        // Configure the mocked store to expect an update action reflecting routine creation.
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 1, updated: 0, deleted: 0))
        ])
        
        // Create an XCTest expectation to handle the asynchronous nature of the operation.
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.createRoutine(routine: routineToCreate)
            .sinkToResult { result in
                // Assert that the routine creation results in success.
                result.assertSuccess()
                // Verify that the actions performed on the mock store match the expectations.
                self.mockedStore.verify()
                // Fulfill the expectation indicating the completion of the asynchronous call.
                expected.fulfill()
            }
            // Store the Combine subscription in a cancel bag to manage its lifecycle.
            .store(in: cancelBag)

        // Wait for the expectation to be fulfilled, with a timeout to avoid endless waiting.
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `readRoutines` method of `RealRoutinesRepository`.
    /// Ensures that the method fetches routines correctly from the persistent store and returns them as expected.
    func test_readRoutines() throws {
        // Setup mock data and expectations
        let routines = RoutineStruct.testData
        mockedStore.actions = .init(expected: [
            .fetch(.init(inserted: 0, updated: 0, deleted: 0))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        // XCTest expectation to wait for asynchronous code
        let expected = XCTestExpectation(description: #function)
        
        // Execute the test
        systemUnderTest.readRoutines()
            .sinkToResult { result in
                // Assert the result matches expected data
                result.assertSuccess(value: routines)
                // Verify mock store interactions
                self.mockedStore.verify()
                // Verify mock store interactions
                expected.fulfill()
            }
            .store(in: cancelBag)
        // Wait for the test to complete
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `updateRoutine` method of `RealRoutinesRepository`.
    /// Ensures that the method updates a routine successfully in the persistent store.
    func test_updateRoutine() throws {
        // Setup a routine to test the update functionality.
        let routines = RoutineStruct.testData
        let routineToUpdate = RoutineStruct.testData[0]
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 1, deleted: 0))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        // XCTest expectation to wait for asynchronous code.
        let expected = XCTestExpectation(description: #function)
        
        // Invoke the updateRoutine function from the system under test (repository).
        systemUnderTest.updateRoutine(routine: routineToUpdate)
            .sinkToResult { result in
                // Assert that the routine update results in success.
                result.assertSuccess()
                // Verify that the actions performed on the mock store match the expectations.
                self.mockedStore.verify()
                // Fulfill the expectation indicating the completion of the asynchronous call.
                expected.fulfill()
            }
            // Store the Combine subscription in a cancel bag to manage its lifecycle.
            .store(in: cancelBag)
        
        // Wait for the expectation to be fulfilled.
        wait(for: [expected], timeout: 0.5)
    }

    
    /// Test for verifying the `deleteRoutine` method of `RealRoutinesRepository`.
    /// Ensures that the method deletes a routine successfully from the persistent store.
    func test_deleteRoutine() throws {
        // Select a routine to test the delete functionality.
        let routines = RoutineStruct.testData
        let routineToDelete = RoutineStruct.testData[0]
        
        // Configure the mocked store to expect an update action reflecting routine deletion.
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 0, deleted: 1))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        // XCTest expectation to wait for asynchronous code.
        let expected = XCTestExpectation(description: #function)
        
        // Invoke the deleteRoutine function from the system under test (repository).
        systemUnderTest.deleteRoutine(routine: routineToDelete)
            .sinkToResult { result in
                // Assert that the routine deletion results in success.
                result.assertSuccess()
                // Verify that the actions performed on the mock store match the expectations.
                self.mockedStore.verify()
                // Fulfill the expectation indicating the completion of the asynchronous call.
                expected.fulfill()
            }
            // Store the Combine subscription in a cancel bag to manage its lifecycle.
            .store(in: cancelBag)
        
        // Wait for the expectation to be fulfilled.
        wait(for: [expected], timeout: 0.5)
    }

}
