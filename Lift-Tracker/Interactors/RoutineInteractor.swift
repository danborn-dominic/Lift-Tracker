//
//  RoutineInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//
//  Description:
//  This file defines the RoutineInteractor protocol and its implementations: RealRoutineInteractor and StubRoutineInteractor.
//  RealRoutineInteractor handles the business logic related to routines, including loading, adding, and deleting routines,
//  and interacting with the RoutinesRepository and AppState. It utilizes Combine for asynchronous operations and state management.
//  StubRoutineInteractor provides a mock implementation for testing and development purposes.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

// Protocol defining the core functionalities for handling routines.
protocol RoutineInteractor {
    // Function to load all routines.
    func loadRoutines()
    
    // Function to add a new routine.
    func addRoutine(routine: RoutineStruct)
    
    // Function to delete an existing routine.
    func deleteRoutine(routine: RoutineStruct)
}

// Concrete implementation of the RoutineInteractor protocol.
class RealRoutineInteractor: RoutineInteractor {
    // Repository for accessing and modifying routines data.
    let routineRepository: RoutinesRepository
    
    // State holder for the application, containing all user data and system states.
    var appState: DataStore<AppState>
    
    // CancelBag to manage and cancel ongoing Combine subscriptions.
    private var cancelBag = CancelBag()
    
    init(routinesRepository: RoutinesRepository, appState: DataStore<AppState>) {
        self.routineRepository = routinesRepository
        self.appState = appState
    }
    
    /// Loads routines from the repository and updates the application state.
    /// This function initiates a fetch request to the routines repository,
    /// sets the application state to loading, and upon receiving data,
    /// updates the state accordingly.
    func loadRoutines() {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the application state for routines to loading, with a reference to the cancelBag.
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        
        // Fetch routines from the routines repository.
        routineRepository.readRoutines()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadable in                           // Convert the result to a Loadable type and update the app state.
                self.appState.value.userData.routines = loadable    // Update the application state with either the fetched routines or an error.

            }
            .store(in: cancelBag)                                   // Store the subscription in the cancelBag to manage its lifecycle.
    }
    
    /// Adds a new routine to the repository and updates the application state.
    /// This function sends a new routine to the routines repository for creation,
    /// sets the application state to loading, and upon successful creation,
    /// reloads the routines to reflect the latest state.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to be added.
    func addRoutine(routine: RoutineStruct) {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the application state for routines to loading, with a reference to the cancelBag.
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        
        // Send the routine to the routines repository for creation.
        routineRepository.createRoutine(routine: routine)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in        // Handle the completion of the network request.
                switch completion {
                case .finished:
                    // On successful creation, set the state to loading again for the upcoming fetch operation.
                    self?.appState.value.userData.routines = .isLoading(last: self?.appState.value.userData.routines.value, cancelBag: cancelBag)
                    self?.loadRoutines()
                case .failure(let error):
                    // On failure, update the state with the error.
                    self?.appState.value.userData.routines = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)                                       // Store the subscription in the cancelBag to manage its lifecycle.
    }
    
    /// Deletes a specific routine from the repository and updates the application state.
    /// This function sends a request to the routines repository to delete a routine,
    /// sets the application state to loading, and upon successful deletion,
    /// reloads the routines to reflect the latest state.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to be deleted.
    func deleteRoutine(routine: RoutineStruct) {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the application state for routines to loading, with a reference to the cancelBag.
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        
        // Send the routine to the routines repository for deletion.
        routineRepository.deleteRoutine(routine: routine)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in        // Handle the completion of the network request.
                switch completion {
                case .finished:
                    // On successful deletion, set the state to loading again for the upcoming fetch operation.
                    self?.appState.value.userData.routines = .isLoading(last: self?.appState.value.userData.routines.value, cancelBag: cancelBag)
                    self?.loadRoutines()
                case .failure(let error):
                    self?.appState.value.userData.routines = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)                                       // Store the subscription in the cancelBag to manage its lifecycle.
    }
}

struct StubRoutineInteractor: RoutineInteractor {
    func loadRoutines() {
    }
    
    func addRoutine(routine: RoutineStruct) {
    }
    
    func deleteRoutine(routine: RoutineStruct) {
    }
}
