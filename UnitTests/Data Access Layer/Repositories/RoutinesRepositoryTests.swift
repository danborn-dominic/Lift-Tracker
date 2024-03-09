//
//  RoutinesRepositoryTests.swift
//  UnitTests
//
//  Description:
//  This test suite is dedicated to validating the behavior of the RealRoutinesRepository in the Lift-Tracker app.
//  It aims to thoroughly test CRUD (Create, Read, Update, Delete) operations provided by the repository to ensure
//  data integrity and consistency with the underlying Core Data store. Each test method simulates typical
//  repository interactions, leveraging a MockedPersistentStore to imitate Core Data operations. This approach
//  allows for the examination of repository functionalities in isolation, without impacting the actual database.
//  Tests cover scenarios such as creating new routines, reading existing routines, updating routine details,
//  and deleting routines. By mocking database interactions and validating expected outcomes, these tests
//  guarantee that the RealRoutinesRepository reliably manages routine data as per the business logic.
//  The test cases use XCTest framework to assert correctness of repository methods, ensuring they perform
//  as intended under various conditions. This ensures the stability and reliability of the routines management
//  feature in the Lift-Tracker application.
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
        let routineToCreate = Routine.testData[0]
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
        let routines = Routine.testData
        let sortedRoutines = routines.sorted(by: { $0.routineName < $1.routineName })
        mockedStore.actions = .init(expected: [
            .fetch(.init(inserted: 0, updated: 0, deleted: 0))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.readRoutines()
            .sinkToResult { result in
                switch result {
                case .success(let fetchedRoutines):
                    let sortedFetchedRoutines = fetchedRoutines.sorted(by: { $0.routineName < $1.routineName })
                    XCTAssertEqual(sortedRoutines, sortedFetchedRoutines)
                case .failure(let error):
                    XCTFail("Fetching routines failed with error: \(error)")
                }
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `updateRoutine` method of `RealRoutinesRepository`.
    /// Ensures that the method updates a routine successfully in the persistent store.
    func test_updateRoutine() throws {
        let routines = Routine.testData
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 1, deleted: 0))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        var routineToUpdate = routines[0]
        routineToUpdate.routineName = "Updated Routine Name"
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.updateRoutine(routine: routineToUpdate)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `deleteRoutine` method of `RealRoutinesRepository`.
    /// Ensures that the method deletes a routine successfully from the persistent store.
    func test_deleteRoutine() throws {
        let routines = Routine.testData
        let routineToDelete = routines[0]
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 0, deleted: 1))
        ])
        try mockedStore.preloadData { context in
            routines.forEach { $0.store(in: context) }
        }
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.deleteRoutine(routine: routineToDelete)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
}
