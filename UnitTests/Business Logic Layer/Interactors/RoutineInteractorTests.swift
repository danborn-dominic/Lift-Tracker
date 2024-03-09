//
//  RoutineInteractorTests.swift
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

class RoutineInteractorTests: XCTestCase {
    
    let appState = CurrentValueSubject<AppState, Never>(AppState())
    var mockedRoutineRepository: MockedRoutinesRepository!
    var subscriptions = Set<AnyCancellable>()
    
    var systemUnderTest: RealRoutineInteractor!
    
    override func setUp() {
        super.setUp()
        appState.value = AppState()
        mockedRoutineRepository = MockedRoutinesRepository()
        systemUnderTest = RealRoutineInteractor(
            routinesRepository: mockedRoutineRepository,
            appState: appState)
    }
    
    override func tearDown() {
        subscriptions = Set<AnyCancellable>()
        super.tearDown()
    }
    
    func test_loadRoutines_success() {
        let list = RoutineStruct.testData
        mockedRoutineRepository.actions = .init(expected: [
            .readRoutines
        ])
        mockedRoutineRepository.readRoutinesResult = .success(list)
        let routines = BindingWithPublisher(value: Loadable<[RoutineStruct]>.notRequested)
        
        systemUnderTest.loadRoutines(routines: routines.binding)
        
        let expected = XCTestExpectation(description: #function)
        
        routines.updatesRecorder.sink { updates in
            XCTAssertEqual(updates, [
                .notRequested,
                .isLoading(last: nil, cancelBag: CancelBag()),
                .loaded(list)
            ])
            self.mockedRoutineRepository.verify()
            expected.fulfill()
        }
        .store(in: &subscriptions)
        wait(for: [expected], timeout: 2)
    }
    
    func test_loadRoutines_fail() {
        let error = NSError.test
        mockedRoutineRepository.actions = .init(expected: [
            .readRoutines
        ])
        
        mockedRoutineRepository.readRoutinesResult = .failure(error)
        let routines = BindingWithPublisher(value: Loadable<[RoutineStruct]>.notRequested)
        
        systemUnderTest.loadRoutines(routines: routines.binding)
        
        let expected = XCTestExpectation(description: #function)
        
        routines.updatesRecorder.sink { updates in
            XCTAssertEqual(updates, [
                .notRequested,
                .isLoading(last: nil, cancelBag: CancelBag()),
                .failed(error)
            ])
            self.mockedRoutineRepository.verify()
            expected.fulfill()
        }
        .store(in: &subscriptions)
        wait(for: [expected], timeout: 2)
    }
    
    func test_addExercise_success() {
        let routineToAdd = RoutineStruct.testData[0]
        mockedRoutineRepository.createRoutineResult = .success(())
        mockedRoutineRepository.actions = .init(expected: [
            .createRoutine(routineToAdd)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.addRoutine(routine: routineToAdd)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_addExercise_fail() {
        let routineToAdd = RoutineStruct.testData[0]
        
        mockedRoutineRepository.actions = .init(expected: [
            .createRoutine(routineToAdd)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.addRoutine(routine: routineToAdd)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_deleteExercise_success() {
        let routineToDelete = RoutineStruct.testData[0]
        mockedRoutineRepository.deleteRoutineResult = .success(())
        mockedRoutineRepository.actions = .init(expected: [
            .deleteRoutine(routineToDelete)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.deleteRoutine(routine: routineToDelete)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_deleteExercise_fail() {
        let routineToDelete = RoutineStruct.testData[0]
        
        mockedRoutineRepository.actions = .init(expected: [
            .deleteRoutine(routineToDelete)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.deleteRoutine(routine: routineToDelete)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_updateExercise_success() {
        let routineToUpdate = RoutineStruct.testData[0]
        mockedRoutineRepository.updateRoutineResult = .success(())
        mockedRoutineRepository.actions = .init(expected: [
            .updateRoutine(routineToUpdate)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.updateRoutine(routine: routineToUpdate)
            .sinkToResult { result in
                result.assertSuccess()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
    
    func test_updateExercise_fail() {
        let routineToUpdate = RoutineStruct.testData[0]
        
        mockedRoutineRepository.actions = .init(expected: [
            .updateRoutine(routineToUpdate)
        ])
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest.updateRoutine(routine: routineToUpdate)
            .sinkToResult { result in
                result.assertFailure()
                self.mockedRoutineRepository.verify()
                expected.fulfill()
            }
            .store(in: &subscriptions)
        wait(for: [expected], timeout: 0.5)
    }
}
