//
//  AppState.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//
//  Description:
//  This file defines the AppState structure, which serves as the central point of truth within the Lift-Tracker app.
//  It encompasses all the necessary stateful data to manage the user interface and system behavior. The AppState
//  consists of various nested structures, each dedicated to a specific aspect of the application's state.
//  This includes user data, view routing information, and system-related states. By leveraging the Equatable
//  protocol, AppState supports efficient state comparisons, enabling seamless state management across the app.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

// AppState serves as the root state object of the application.
// It holds all sub-states relevant to different parts of the app.
struct AppState: Equatable {
    // UserData holds the state related to the user's data.
    var userData = UserData()
    // ViewRouting holds the state for navigation and view transitions.
    var routing = ViewRouting()
    // System holds general app-wide state, like app activation status.
    var system = System()
}

// Extension for managing user-specific data.
extension AppState {
    // UserData encapsulates the state of user-related data such as routines and exercises.
    struct UserData: Equatable {
        // routines holds the state of user's routines.
        var routines: Loadable<[RoutineStruct]> = .notRequested
        // exercises holds the state of the user's exercise library.
        var exerciseLibrary: Loadable<ExerciseLibraryStruct> = .notRequested
    }
}

// Extension for managing view routing.
extension AppState {
    // ViewRouting encapsulates the navigation state of the app.
    struct ViewRouting: Equatable {
        // routineList holds the routing state for the routines view.
        var routineList = RoutinesView.Routing()
    }
}

// Extension for system-wide state management.
extension AppState {
    // System encapsulates app-wide settings and system flags.
    struct System: Equatable {
        // isActive indicates whether the app is currently active.
        var isActive: Bool = false
    }
}

// DEBUG extension for previewing and testing.
#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        state.userData.routines = .loaded(RoutineStruct.mockData)
        return state
    }
}
#endif
