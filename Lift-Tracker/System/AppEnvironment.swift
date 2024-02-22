//
//  AppEnvironment.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/9/23.
//
//  Description:
//  This file defines the AppEnvironment structure, which is responsible for initializing and
//  providing access to the core components of the application such as the dependency injection container
//  and the system events handler. It sets up the application state, repositories, interactors, and other
//  necessary services for the application to function properly.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    /// Bootstraps the application environment.
    /// This method sets up and returns an AppEnvironment instance with all necessary components initialized.
    /// It creates the application state, core data stack, repositories, interactors, and dependency injection container.
    ///
    /// - Returns:
    ///     - AppEnvironment instance with all necessary components initialized.
    static func bootstrap() -> AppEnvironment {
        // Initialize the application state.
        let appState = DataStore<AppState>(AppState())
        
        // Set up the Core Data stack for persistence.
        let persistentStore = CoreDataStack()
        
        // Create repositories for routines and exercises.
        let workoutsRepository = RealRoutinesRepository(persistentStore: persistentStore)
        let exerciseRepository = RealExerciseLibraryRepository(persistentStore: persistentStore)
        
        // Configure interactors with the repositories and application state.
        let interactors = configuredInteractors(appState: appState, workoutsRepository: workoutsRepository, exerciseRepository: exerciseRepository)
        
        // Initialize the dependency injection container with the application state and interactors.
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        
        // Set up the system events handler.
        let systemEventsHandler = RealSystemEventsHandler(container: diContainer)
        
        // Return the fully configured application environment.
        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
    }
    
    /// Configures and returns the interactors for the application.
    /// This method initializes the interactors required for handling routines and exercises,
    /// providing them with the necessary repositories and application state.
    ///
    /// - Parameters:
    ///   - appState: The application state to be used by the interactors.
    ///   - workoutsRepository: The routines repository for routines-related operations.
    ///   - exerciseRepository: The exercise library repository for exercises-related operations.
    /// - Returns:
    ///     - Interactors for the DI container.
    private static func configuredInteractors(appState: DataStore<AppState>, workoutsRepository: RoutinesRepository, exerciseRepository: ExerciseLibraryRepository) -> DIContainer.Interactors {
        
        // Initialize the routine interactor with the routines repository and application state.
        let routineInteractor = RealRoutineInteractor(routinesRepository: workoutsRepository, appState: appState)
        
        // Initialize the exercise interactor with the exercise library repository and application state.
        let exerciseInteractor = RealExerciseInteractor(exercisesRepository: exerciseRepository, appState: appState)
        
        // Return the configured interactors.
        return .init(routineInteractor: routineInteractor, exerciseInteractor: exerciseInteractor)
    }
}
