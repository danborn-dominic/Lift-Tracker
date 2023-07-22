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
        self.container = container
    }

    var body: some View {

        TabView {
            NavigationView {
                HomeView()
            }
                .tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }

            NavigationView {
                WorkoutsView()
            }
                .tabItem {
                VStack {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Routines")
                }
            }

            NavigationView {
                ExercisesView()
            }
                .tabItem {
                VStack {
                    Image(systemName: "dumbbell")
                    Text("Exercises")
                }
            }

            NavigationView {
                ProgressView()
            }
                .tabItem {
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Progress")
                }
            }

            NavigationView {
                SettingsView()
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

// MARK: - Preview

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(container: .preview)
        }
    }
#endif
