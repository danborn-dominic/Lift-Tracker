//
//  InteractorsContainer.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//
//  Description:
//  This file contains the definition of the Interactors container within the Dependency Injection Container (DIContainer).
//  It holds instances of different interactors like RoutineInteractor and ExerciseInteractor, which are responsible for handling
//  business logic related to routines and exercises respectively. This container facilitates the injection of these interactors
//  into different parts of the application.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

// Extension of DIContainer to include the interactors container.
extension DIContainer {
    // Interactors struct holds instances of various interactors.
    struct Interactors {
        // Instance of RoutineInteractor to handle routine-related logic.
        let routineInteractor: RoutineInteractor
        // Instance of ExerciseInteractor to handle exercise-related logic.
        let exerciseInteractor: ExerciseInteractor

        // Initializes the Interactors container with given interactors.
        init(routineInteractor: RoutineInteractor, exerciseInteractor: ExerciseInteractor) {
            self.routineInteractor = routineInteractor
            self.exerciseInteractor = exerciseInteractor
        }
    }
}

// Extension to provide stub implementations for testing or preview purposes.
extension DIContainer.Interactors {
    // Provides stub interactors with mocked functionalities.
    static var stub: DIContainer.Interactors {
        // Stub instance of RoutineInteractor.
        let routineInteractor = StubRoutineInteractor()
        // Stub instance of ExerciseInteractor.
        let exerciseInteractor = StubExerciseInteractor()
        // Returns a container with the stub interactors.
        return DIContainer.Interactors(routineInteractor: routineInteractor, exerciseInteractor: exerciseInteractor)
    }
}
