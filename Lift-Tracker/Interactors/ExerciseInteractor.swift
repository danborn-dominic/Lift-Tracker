//
//  ExerciseInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/8/24.
//
//  Description:
//  This file defines the ExerciseInteractor protocol and its implementations: RealExerciseInteractor and StubExerciseInteractor.
//  RealExerciseInteractor handles the business logic related to exercises, including loading, adding, and deleting exercises,
//  and interacting with the ExercisesRepository and AppState. It utilizes Combine for asynchronous operations and state management.
//  StubExerciseInteractor provides a mock implementation for testing and development purposes.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation

// Protocol defining the core functionalities for handling routines.
protocol ExerciseInteractor {
    // Function to load all exercises.
    func loadExercises()
    
    // Function to add a new exercise.
    func addExercise(exercise: ExerciseStruct)
    
    // Function to delete an existing exercise.
    func deleteExercise(exercise: ExerciseStruct)
}

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
    /// This function initializes a new `CancelBag` for managing the network call's lifecycle.
    /// It sets the `exerciseLibrary` state in the `appState` to `.isLoading` and proceeds to fetch exercises
    /// from the `exercisesRepository`. Upon receiving the data, it updates the `exerciseLibrary` state
    /// to reflect the current status (`notRequested`, `isLoading`, `loaded`, or `failed`).
    /// In cases where data is received as `nil`, a new instance of `ExerciseLibraryStruct` is created
    /// and used to maintain a non-optional state in the `appState`.
    ///
    /// The function utilizes `sinkToLoadable` to handle the asynchronous nature of data fetching,
    /// converting the fetched data into a `Loadable` type, and stores the subscription in the `cancelBag`.
    func loadExercises() {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the application state for exerciseLibrary to loading, with a reference to the cancelBag.
        appState.value.userData.exerciseLibrary.setIsLoading(cancelBag: cancelBag)

        // Fetch routines from the routines repository.
        exercisesRepository.readExercises()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadable in
                // Convert the result to a non-optional Loadable type and update the app state.
                switch loadable {
                case .notRequested:
                    self.appState.value.userData.exerciseLibrary = .notRequested
                case .isLoading(let last, let cancelBag):
                    // Convert 'last' to non-optional before assigning it to appState.
                    self.appState.value.userData.exerciseLibrary = .isLoading(last: last ?? ExerciseLibraryStruct(id: UUID()), cancelBag: cancelBag)
                case .loaded(let library):
                    // Convert 'library' to non-optional before assigning it to appState.
                    self.appState.value.userData.exerciseLibrary = .loaded(library ?? ExerciseLibraryStruct(id: UUID()))
                case .failed(let error):
                    self.appState.value.userData.exerciseLibrary = .failed(error)
                }
            }
            .store(in: cancelBag)                                       // Store the subscription in the cancelBag to manage its lifecycle.
    }
    
    /// Adds a new exercise to the repository and updates the application state.
    /// This function sends a new exercise to the routines repository for creation,
    /// sets the application state to loading, and upon successful creation,
    /// reloads the exercises to reflect the latest state.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be added.
    func addExercise(exercise: ExerciseStruct) {
        // Initialize a new CancelBag for lifecycle management of this network call.
        let cancelBag = CancelBag()
        // Update the exerciseLibrary state to isLoading, initiating the add operation.
        appState.value.userData.exerciseLibrary.setIsLoading(cancelBag: cancelBag)
        
        // Attempt to create a new exercise in the repository.
        exercisesRepository.createExercise(exercise: exercise)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // On successful addition, set the exerciseLibrary state to isLoading and reload exercises.
                    self?.appState.value.userData.exerciseLibrary = .isLoading(last: self?.appState.value.userData.exerciseLibrary.value, cancelBag: cancelBag)
                    self?.loadExercises()
                case .failure(let error):
                    // On failure, update the exerciseLibrary state to failed with the encountered error.
                    self?.appState.value.userData.exerciseLibrary = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)                                       // Store the subscription in the cancelBag to manage its lifecycle.
    }
    
    /// Deletes a specific exercise from the repository and updates the application state.
    ///
    /// This function sends a request to the exercises repository to delete an exercise,
    /// sets the application state for `exerciseLibrary` to loading, and upon successful deletion,
    /// reloads the exercises to reflect the latest state.
    ///
    /// The function uses a `sink` to handle the asynchronous nature of the operation, with separate handlers
    /// for completion and value reception. The subscription is managed by the `cancelBag`.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be deleted.
    func deleteExercise(exercise: ExerciseStruct) {
        // Initialize a new CancelBag for lifecycle management of this network call.
        let cancelBag = CancelBag()
        // Update the exerciseLibrary state to isLoading, initiating the delete operation.
        appState.value.userData.exerciseLibrary.setIsLoading(cancelBag: cancelBag)
        
        // Attempt to delete the specified exercise from the repository.
        exercisesRepository.deleteExercise(exercise: exercise)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // On successful deletion, set the exerciseLibrary state to isLoading and reload exercises.
                    self?.appState.value.userData.exerciseLibrary = .isLoading(last: self?.appState.value.userData.exerciseLibrary.value, cancelBag: cancelBag)
                    self?.loadExercises()
                case .failure(let error):
                    // On failure, update the exerciseLibrary state to failed with the encountered error.
                    self?.appState.value.userData.exerciseLibrary = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)                                       // Store the subscription in the cancelBag to manage its lifecycle.
    }
}

struct StubExerciseInteractor: ExerciseInteractor {
    func loadExercises() {
    }
    
    func addExercise(exercise: ExerciseStruct) {
    }
    
    func deleteExercise(exercise: ExerciseStruct) {
    }
}
