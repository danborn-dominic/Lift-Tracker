//
//  ContentView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/27/23.
//
//  Description:
//  This file defines the ContentView struct, which serves as the main view of the Lift-Tracker application.
//  It sets up a tab-based navigation structure, providing access to different sections of the app such as
//  Home, Routines, Exercises, Progress, and More. The view relies on the DIContainer to inject dependencies
//  into its child views.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

/// The main view of the Lift-Tracker application, organizing the navigation structure.
struct ContentView: View {
    
    /// The dependency injection container, holding app-wide dependencies.
    private let container: DIContainer
    
    /// Initializes a new ContentView with the provided DIContainer.
    init(container: DIContainer) {
        self.container = container
    }
    
    /// The content and layout of the view.
    var body: some View {
        ZStack {
            Color.backgroundColor
            TabView {
                NavigationView {
                    HomeView(container: container)
                        .modifier(RootViewAppearance())
                }
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                
                NavigationView {
                    RoutinesView(container: container)
                        .modifier(RootViewAppearance())
                }
                .tabItem {
                    VStack {
                        Image(systemName: "figure.strengthtraining.traditional")
                        Text("Routines")
                    }
                }

                NavigationView {
                    ExercisesView(container: container)
                        .modifier(RootViewAppearance())
                }
                .tabItem {
                    VStack {
                        Image(systemName: "dumbbell")
                        Text("Exercises")
                    }
                }
                
                NavigationView {
                    ProgressView(container: container)
                        .modifier(RootViewAppearance())
                }
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Progress")
                    }
                }
                
                NavigationView {
                    SettingsView(container: container)
                        .modifier(RootViewAppearance())
                }
                .tabItem {
                    VStack {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
                }
            }
        }
        .modifier(TabBarAppearanceModifier(color: .black))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
#endif
