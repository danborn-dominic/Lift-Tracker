//
//  AppEnvironment.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/9/23.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {

    static func bootstrap() -> AppEnvironment {
        print("INFO bootstrapping")
        let appState = DataStore<AppState>(AppState())

        let persistentStore = CoreDataStack()
        let workoutsRepository = RealRoutinesRepository(persistentStore: persistentStore)
        let exerciseRepository = RealExerciseLibraryRepository(persistentStore: persistentStore)

        let interactors = configuredInteractors(appState: appState, workoutsRepository: workoutsRepository, exerciseRepository: exerciseRepository)
        let diContainer = DIContainer(appState: appState, interactors: interactors)

        let systemEventsHandler = RealSystemEventsHandler(container: diContainer)

        print("INFO finished app environment setup")

        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
    }

    private static func configuredInteractors(appState: DataStore<AppState>, workoutsRepository: RoutinesRepository, exerciseRepository: ExerciseLibraryRepository) -> DIContainer.Interactors {
        let workoutInteractor = RealRoutineInteractor(workoutsRepository: workoutsRepository, appState: appState)
        let exerciseInteractor = RealExerciseInteractor(exercisesRepository: exerciseRepository, appState: appState)
        return .init(workoutInteractor: workoutInteractor, exerciseInteractor: exerciseInteractor)
    }
}

