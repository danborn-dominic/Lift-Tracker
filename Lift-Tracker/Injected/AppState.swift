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
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var workoutList = WorkoutListView.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}
