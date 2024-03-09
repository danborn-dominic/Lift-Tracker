//
//  MockedInteractors.swift
//  UnitTests
//
//  Description:
//  This file provides mock implementations of the RoutineInteractor and ExerciseInteractor protocols used in the Lift-Tracker app.
//  These mocks are utilized for unit testing, allowing for the simulation of routine and exercise interactions without executing actual business logic.
//  Each mocked interactor includes a set of actions that can be expected and verified during tests, ensuring the correctness of the interactor's usage.
//  The file also extends DIContainer.Interactors to include a static method for creating a mocked version of interactors, enhancing the ease of setup for testing.
//  The `verify` function in the extension is crucial for asserting that the expected actions match the actual actions performed during the tests.
//  Overall, these mocks and utilities significantly aid in the unit testing process, providing a controlled environment for testing interactions within the app.
//
//  Created by Dominic Danborn on 2/29/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import SwiftUI
import Combine
@testable import Lift_Tracker

struct MockedRoutineInteractor: Mock, RoutineInteractor {
    
    enum Action: Equatable {
        case loadRoutines
        case addRoutine(Routine)
        case updateRoutine(Routine)
        case deleteRoutine(Routine)
    }
    
    let actions: MockActions<Action>
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    /// Simulates the loading of routines.
    /// This function registers the action and provides a stub implementation.
    func loadRoutines(routines: LoadableSubject<[Routine]>) {
        register(.loadRoutines)
    }
    
    /// Simulates the addition of a new routine.
    /// This function registers the action with the provided routine and provides a stub implementation.
    ///
    /// - Parameters:
    ///   - routine: The `RoutineStruct` instance to be added.
    func addRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        register(.addRoutine(routine))
        return Just<Void>.withErrorType(Error.self)
    }
    
    /// Simulates the update of an existing routine.
    /// This function registers the action with the provided routine and provides a stub implementation.
    ///
    /// - Parameters:
    ///   - routine: The `RoutineStruct` instance to be updated.
    func updateRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        register(.updateRoutine(routine))
        return Just<Void>.withErrorType(Error.self)
    }
    
    /// Simulates the deletion of a specific routine.
    /// This function registers the action with the provided routine and provides a stub implementation.
    ///
    /// - Parameters:
    ///   - routine: The `RoutineStruct` instance to be deleted.
    func deleteRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        register(.deleteRoutine(routine))
        return Just<Void>.withErrorType(Error.self)
    }
}

struct MockedExerciseInteractor: Mock, ExerciseInteractor {

    enum Action: Equatable {
        case loadExercises
        case addExercise(Exercise)
        case updateExercise(Exercise)
        case deleteExercise(Exercise)
    }
    
    let actions: MockActions<Action>
    
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    /// Simulates loading exercises.
    /// Records the action and doesn't perform any real operation.
    func loadExercises(exercises: LoadableSubject<[Exercise]>) {
        register(.loadExercises)
    }
    
    /// Simulates adding a new exercise.
    /// Records the action with the provided exercise and doesn't perform any real operation.
    ///
    /// - Parameters:
    ///   - exercise: The `ExerciseStruct` instance to be added.
    func addExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        register(.addExercise(exercise))
        return Just<Void>.withErrorType(Error.self)
    }
    
    /// Simulates the update of an existing routine.
    /// This function registers the action with the provided routine and provides a stub implementation.
    ///
    /// - Parameters:
    ///   - exercise: The `ExerciseStruct` instance to be updated.
    func updateExercise(exercise: Exercise) -> AnyPublisher<Void, any Error> {
        register(.updateExercise(exercise))
        return Just<Void>.withErrorType(Error.self)
    }
    
    /// Simulates deleting an existing exercise.
    /// Records the action with the specified exercise and doesn't perform any real operation.
    ///
    /// - Parameters:
    ///   - exercise: The `ExerciseStruct` instance to be deleted.
    func deleteExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        register(.deleteExercise(exercise))
        return Just<Void>.withErrorType(Error.self)
    }
}

extension DIContainer.Interactors {
    
    /// Creates a mocked version of `DIContainer.Interactors` for unit testing.
    /// This function initializes `DIContainer.Interactors` with mock interactors instead of real ones.
    /// It allows for setting up expected actions in the mock interactors for verifying interactions during tests.
    ///
    /// - Parameters:
    ///   - routineInteractor: An array of expected actions for the `MockedRoutineInteractor`.
    ///   - exerciseInteractor: An array of expected actions for the `MockedExerciseInteractor`.
    ///
    /// - Returns: An instance of `DIContainer.Interactors` populated with mock interactors.
    static func mocked(
        routineInteractor: [MockedRoutineInteractor.Action] = [],
        exerciseInteractor: [MockedExerciseInteractor.Action] = []
    ) -> DIContainer.Interactors {
        // Initialize `DIContainer.Interactors` with mocked interactors, passing in the expected actions.
        .init(routineInteractor: MockedRoutineInteractor(expected: routineInteractor),
              exerciseInteractor: MockedExerciseInteractor(expected: exerciseInteractor))
    }
    
    /// Verifies that the actions recorded in the mock interactors match the expected actions.
    /// This method is used in unit tests to ensure that the interactors are being used as expected.
    ///
    /// - Parameters:
    ///   - file: The file name in which the verification is taking place. Used for reporting in test results.
    ///   - line: The line number at which the verification is called. Used for reporting in test results.
    func verify(file: StaticString = #file, line: UInt = #line) {
        // Verify actions for the MockedRoutineInteractor if it's present.
        (routineInteractor as? MockedRoutineInteractor)?
            .verify(file: file, line: line)
        
        // Verify actions for the MockedExerciseInteractor if it's present.
        (exerciseInteractor as? MockedExerciseInteractor)?
            .verify(file: file, line: line)
    }
}
