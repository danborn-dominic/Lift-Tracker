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
    func loadRoutines(routines: LoadableSubject<[RoutineStruct]>)
    
    // Function to add a new routine.
    func addRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
    
    // Function to delete an existing routine.
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
}

// Implementation of the RoutineInteractor protocol.
class RealRoutineInteractor: RoutineInteractor {
    // Repository for accessing and modifying routines data.
    let routinesRepository: RoutinesRepository
    
    // State holder for the application, containing all user data and system states.
    var appState: DataStore<AppState>
    
    // CancelBag to manage and cancel ongoing Combine subscriptions.
    private var cancelBag = CancelBag()
    
    init(routinesRepository: RoutinesRepository, appState: DataStore<AppState>) {
        self.routinesRepository = routinesRepository
        self.appState = appState
    }
    
    /// Loads routines from the repository
    ///
    /// - Parameter routines: A `LoadableSubject` that holds the state of the routines being loaded.
    func loadRoutines(routines: LoadableSubject<[RoutineStruct]>) {
        // Initialize a new CancelBag to manage the lifecycle of this network call.
        let cancelBag = CancelBag()
        // Set the passed routines subject to a loading state.
        routines.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        // Fetch routines from the routines repository.
        routinesRepository.readRoutines()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadableRoutines in
                // Update the routines subject with the fetched routines.
                routines.wrappedValue = loadableRoutines
            }
            .store(in: cancelBag)
    }
    
    /// Adds a new routine to the repository.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to be added.
    func addRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        return routinesRepository.createRoutine(routine: routine)
    }
    
    /// Deletes a specific routine from the repository and updates the application state.
    /// This function sends a request to the routines repository to delete a routine,
    /// sets the application state to loading, and upon successful deletion,
    /// reloads the routines to reflect the latest state.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to be deleted.
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        return routinesRepository.deleteRoutine(routine: routine)
    }
}

struct StubRoutineInteractor: RoutineInteractor {
    func loadRoutines(routines: LoadableSubject<[RoutineStruct]>) {
    }
    
    func addRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
}