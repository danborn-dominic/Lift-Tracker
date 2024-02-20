//
//  AppState.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserData: Equatable {
        var workouts: Loadable<[WorkoutStruct]> = .notRequested
        var exercises: Loadable<ExerciseLibraryStruct> = .notRequested
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var workoutList = RoutinesView.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        state.userData.workouts = .loaded(WorkoutStruct.mockData)
        return state
    }
}
#endif
