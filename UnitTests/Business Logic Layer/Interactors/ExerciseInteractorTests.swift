//
//  ExerciseInteractorTests.swift
//  UnitTests
//
// Description:
//
//  Created by Dominic Danborn on 3/8/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import Combine
@testable import Lift_Tracker

class ExerciseInteractorTests: XCTestCase {
    
    let appState = CurrentValueSubject<AppState, Never>(AppState())
    var mockedExerciseLibraryRepository: MockedExerciseLibraryRepository!
    var subscriptions = Set<AnyCancellable>()
    
    var systemUnderTest: RealExerciseInteractor!
    
    override func setUp() {
        super.setUp()
        appState.value = AppState()
        mockedExerciseLibraryRepository = MockedExerciseLibraryRepository()
        systemUnderTest = RealExerciseInteractor(
            exercisesRepository: mockedExerciseLibraryRepository,
            appState: appState)
    }
    
    override func tearDown() {
        subscriptions = Set<AnyCancellable>()
        super.tearDown()
    }
    
    func test_loadExercises_success() {
        let list = ExerciseStruct.testData
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .readExercises
        ])
        mockedExerciseLibraryRepository.readExercisesResult = .success(list)
        let exercises = BindingWithPublisher(value: Loadable<[ExerciseStruct]>.notRequested)
        
        systemUnderTest.loadExercises(exercises: exercises.binding)
        
        let expected = XCTestExpectation(description: #function)
        
        exercises.updatesRecorder.sink { updates in
            XCTAssertEqual(updates, [
                .notRequested,
                .isLoading(last: nil, cancelBag: CancelBag()),
                .loaded(list)
            ])
            self.mockedExerciseLibraryRepository.verify()
            expected.fulfill()
        }
        .store(in: &subscriptions)
        wait(for: [expected], timeout: 2)
    }
    
    func test_loadRoutines_fail() {
        let error = NSError.test
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .readExercises
        ])
        
        mockedExerciseLibraryRepository.readExercisesResult = .failure(error)
        let exercises = BindingWithPublisher(value: Loadable<[ExerciseStruct]>.notRequested)
        
        systemUnderTest.loadExercises(exercises: exercises.binding)
        
        let expected = XCTestExpectation(description: #function)
        
        exercises.updatesRecorder.sink { updates in
            XCTAssertEqual(updates, [
                .notRequested,
                .isLoading(last: nil, cancelBag: CancelBag()),
                .failed(error)
            ])
            self.mockedExerciseLibraryRepository.verify()
            expected.fulfill()
        }
        .store(in: &subscriptions)
        wait(for: [expected], timeout: 2)
    }
    
    func test_addExercise_success() {
        let exerciseToAdd = ExerciseStruct.testData[0]
        mockedExerciseLibraryRepository.createExerciseResult = .success(())
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .createExercise(exerciseToAdd)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.addExercise(exercise: exerciseToAdd)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_addExercise_fail() {
        let exerciseToAdd = ExerciseStruct.testData[0]
        
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .createExercise(exerciseToAdd)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.addExercise(exercise: exerciseToAdd)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_deleteExercise_success() {
        let exerciseToDelete = ExerciseStruct.testData[0]
        mockedExerciseLibraryRepository.deleteExerciseResult = .success(())
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .deleteExercise(exerciseToDelete)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.deleteExercise(exercise: exerciseToDelete)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_deleteExercise_fail() {
        let exerciseToDelete = ExerciseStruct.testData[0]
        
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .deleteExercise(exerciseToDelete)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.deleteExercise(exercise: exerciseToDelete)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_updateExercise_success() {
        let exerciseToUpdate = ExerciseStruct.testData[0]
        mockedExerciseLibraryRepository.updateExerciseResult = .success(())
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .updateExercise(exerciseToUpdate)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.updateExercise(exercise: exerciseToUpdate)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_updateExercise_fail() {
        let exerciseToUpdate = ExerciseStruct.testData[0]
        
        mockedExerciseLibraryRepository.actions = .init(expected: [
            .updateExercise(exerciseToUpdate)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.updateExercise(exercise: exerciseToUpdate)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedExerciseLibraryRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
}
