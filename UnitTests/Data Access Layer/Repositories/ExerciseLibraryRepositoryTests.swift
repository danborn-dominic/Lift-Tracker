//
//  ExerciseLibraryRepositoryTests.swift
//  UnitTests
//
//  Description:
//  This file encompasses a series of unit tests targeting the RealExerciseLibraryRepository class
//  within the Lift-Tracker application. The tests aim to thoroughly validate the functionality
//  of methods handling the creation, reading, updating, and deletion of exercises in the exercise library.
//  Through the use of a mocked persistent store, the tests simulate real-world data interactions
//  in a controlled environment, ensuring that the ExerciseLibraryRepository functions as intended
//  without actually modifying any persistent data. Each test case focuses on a specific method
//  of the repository, asserting expected outcomes and confirming the integrity of the application's
//  data layer regarding exercise management. This systematic approach plays a vital role in maintaining
//  the reliability and robustness of the application's core functionality related to exercise data handling.
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import Foundation

import XCTest
import Combine
@testable import Lift_Tracker

class ExerciseLibraryRepositoryTests: XCTestCase {
    
    var systemUnderTest: RealExerciseLibraryRepository!
    
    var mockedStore: MockedPersistentStore!
    
    var cancelBag = CancelBag()
    
    override func setUp() {
        super.setUp()
        mockedStore = MockedPersistentStore()
        systemUnderTest = RealExerciseLibraryRepository(persistentStore: mockedStore)
        mockedStore.verify()
    }
    
    override func tearDown() {
        cancelBag = CancelBag()
        systemUnderTest = nil
        mockedStore = nil
        super.tearDown()
    }
    
    /// Test for verifying the `createExercise` method of `RealExerciseLibraryRepository`.
    /// Ensures that the method creates an exercise successfully in the persistent store.
    func test_createExercise() throws {
        let exerciseToCreate = ExerciseStruct.testData[0]
        
        // Configure the mocked store to expect an update action reflecting routine creation.
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 1, updated: 1, deleted: 0))
        ])
        let library = ExerciseLibraryStruct(id: UUID())
        // Load test data into the context
        try mockedStore.preloadData { context in
            library.store(in: context)
        }
        
        // Create an XCTest expectation to handle the asynchronous nature of the operation.
        let expected = XCTestExpectation(description: #function)
        
        // Call the tested method
        systemUnderTest.createExercise(exercise: exerciseToCreate)
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
        
        // Wait for the expectation to be fulfilled.
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `readExercises` method of `RealExerciseLibraryRepository`.
    /// Ensures that the method fetches exercises correctly from the persistent store and returns them as expected.
    func test_readExercises() throws {
        let exercises = ExerciseStruct.testData
        let sortedExercises = exercises.sorted(by: { $0.exerciseName < $1.exerciseName })
        mockedStore.actions = .init(expected: [
            .fetchOne(.init(inserted: 0, updated: 0, deleted: 0))
        ])
        var library = ExerciseLibraryStruct(id: UUID())
        library.exercises = exercises
        try mockedStore.preloadData { context in
            library.store(in: context)
        }
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.readExercises()
            .sinkToResult { result in
                switch result {
                case .success(let fetchedLibrary):
                    let fetchedExercises = fetchedLibrary?.exercises
                    let sortedFetchedExercises = fetchedExercises!.sorted(by: {
                        $0.exerciseName < $1.exerciseName })
                    XCTAssertEqual(sortedExercises, sortedFetchedExercises)
                case .failure(let error):
                    XCTFail("Fetching exercises failed with error: \(error)")
                }
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `updateExercise` method of `RealExerciseLibraryRepository`.
    /// Ensures that the method updates an exercise successfully in the persistent store.
    func test_updateExercise() throws {
        let exercises = ExerciseStruct.testData
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 1, deleted: 0))
        ])
        var library = ExerciseLibraryStruct(id: UUID())
        library.exercises = exercises
        try mockedStore.preloadData { context in
            library.store(in: context)
        }
        
        var exerciseToUpdate = exercises[0]
        exerciseToUpdate.exerciseName = "Updated Exercise Name"
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.updateExercise(exercise: exerciseToUpdate)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
    
    /// Test for verifying the `deleteExercise` method of `RealExerciseLibraryRepository`.
    /// Ensures that the method deletes an exercise successfully from the persistent store.
    func test_deleteExercise() throws {
        let exercises = ExerciseStruct.testData
        let exerciseToDelete = exercises[0]
        mockedStore.actions = .init(expected: [
            .update(.init(inserted: 0, updated: 2, deleted: 1))
        ])
        
        var library = ExerciseLibraryStruct(id: UUID())
        library.exercises = exercises
        try mockedStore.preloadData { context in
            library.store(in: context)
        }
        
        let expected = XCTestExpectation(description: #function)
        systemUnderTest.deleteExercise(exercise: exerciseToDelete)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedStore.verify()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 0.5)
    }
}
