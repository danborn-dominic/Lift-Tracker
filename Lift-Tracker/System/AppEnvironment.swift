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
        let appState = WorkoutStore<AppState>(AppState())

        let persistentStore = CoreDataStack()
        let workoutsRepository = RealWorkoutsRepository(persistentStore: persistentStore)

        let interactors = configuredInteractors(appState: appState, workoutsRepository: workoutsRepository)
        let diContainer = DIContainer(appState: appState, interactors: interactors)

        let systemEventsHandler = RealSystemEventsHandler(container: diContainer)

        print("INFO finished app environment setup")

        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
    }

    private static func configuredInteractors(appState: WorkoutStore<AppState>, workoutsRepository: WorkoutsRepository) -> DIContainer.Interactors {
        let workoutInteractor = RealWorkoutInteractor(workoutsRepository: workoutsRepository, appState: appState)

        return .init(workoutInteractor: workoutInteractor)
    }
}

