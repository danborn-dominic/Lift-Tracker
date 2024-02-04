//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Your Name on Today's Date.
//  Copyright (c) 2023 Your Name. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    private let container: DIContainer

    init(container: DIContainer) {
        print("INFO ContentView init: DIContainer injected")
        self.container = container
    }

    var body: some View {
        var debug = print("INFO ContentView body: rendering views with DIContainer")
        
        TabView {
            NavigationView {
                HomeView(container: container)
            }
                .tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }

            NavigationView {
                WorkoutsView(container: container)
            }
                .tabItem {
                VStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Routines")
                }
            }

            NavigationView {
                ExercisesView(container: container)
            }
                .tabItem {
                VStack {
                    Image(systemName: "dumbbell")
                    Text("Exercises")
                }
            }

            NavigationView {
                ProgressView(container: container)
            }
                .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
            }

            NavigationView {
                SettingsView(container: container)
            }
                .tabItem {
                VStack {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
            }

        }

    }
}
