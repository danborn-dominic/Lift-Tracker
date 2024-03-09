//
//  ExerciseInteractor.swift
//  Lift-Tracker
//
//  Description:
//  This file defines the ExerciseInteractor protocol and its implementations: RealExerciseInteractor and StubExerciseInteractor.
//  RealExerciseInteractor handles the business logic related to exercises, including loading, adding, and deleting exercises,
//  and interacting with the ExercisesRepository and AppState. It utilizes Combine for asynchronous operations and state management.
//  StubExerciseInteractor provides a mock implementation for testing and development purposes.
//
//  Created by Dominic Danborn on 2/8/24.
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Combine
import Foundation

// Concrete implementation of the ExerciseInteractor protocol.
class RealExerciseInteractor: ExerciseInteractor {
    
    // Repository for accessing and modifying exercise data.
    let exercisesRepository: ExerciseLibraryRepository
    
    // State holder for the application, containing all user data and system states.
    var appState: DataStore<AppState>
    
    // CancelBag to manage and cancel ongoing Combine subscriptions.
    private var cancelBag = CancelBag()
    
    init(exercisesRepository: ExerciseLibraryRepository, appState: DataStore<AppState>) {
        self.exercisesRepository = exercisesRepository
        self.appState = appState
    }
    
    /// Loads exercises from the repository and updates the application state.
    ///
    /// - Parameter exercises: A `LoadableSubject` that holds the state of the exercises being loaded.
    func loadExercises(exercises: LoadableSubject<[ExerciseStruct]>) {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the passed exercises subject to a loading state
        exercises.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        // Fetch the exercises from the exercise repository
        exercisesRepository.readExercises()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadableExercises in
                exercises.wrappedValue = loadableExercises
            }
            .store(in: cancelBag)
    }
    
    /// Adds a new exercise to the repository.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be added.
    func addExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        return exercisesRepository.createExercise(exercise: exercise)
    }
    
    /// Updates an exercise that already exists in  the repository.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be updated.
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, any Error> {
        return exercisesRepository.updateExercise(exercise: exercise)
    }
    
    /// Deletes a specific exercise from the repository.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be deleted.
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        return exercisesRepository.deleteExercise(exercise: exercise)
    }
}

struct StubExerciseInteractor: ExerciseInteractor {
    
    func loadExercises(exercises: LoadableSubject<[ExerciseStruct]>) {
    }
    
    func addExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, any Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
}
