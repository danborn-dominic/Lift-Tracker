//
//  DependencyInjector.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//
//  Description:
//  This file defines the Dependency Injection (DI) Container for the Lift-Tracker app. The DIContainer
//  struct serves as a central point for managing dependencies throughout the app. It includes
//  AppState for maintaining application state and Interactors for handling business logic.
//  This container is injected into the SwiftUI environment, allowing views to access the app state
//  and interactors as needed. The file also includes extensions for easily injecting the container
//  into views and provides a mechanism for creating a preview environment for development and testing.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {
    
    // AppState manages the overall application state.
    let appState: DataStore<AppState>
    
    // Interactors handle the business logic of the application.
    let interactors: Interactors
    
    // Initializes the DIContainer with given AppState and Interactors.
    init(appState: DataStore<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    // Convenience initializer to directly pass AppState.
    init(appState: AppState, interactors: Interactors) {
        self.init(appState: DataStore<AppState>(appState), interactors: interactors)
    }
    
    // Provides a default value for the DIContainer. Throws a fatal error if the container isn't provided.
    static var defaultValue: Self {
        fatalError("DIContainer is not provided: Attempt to access DIContainer before it was injected")
    }
}

extension EnvironmentValues {
    // Injected property for accessing DIContainer within the SwiftUI environment.
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(appState: .init(AppState.preview), interactors: .stub)
    }
}
#endif

extension View {
    /// Injects the given AppState and Interactors into the SwiftUI View.
    ///
    /// - Parameters:
    ///   - appState: The AppState object to be used throughout the app.
    ///   - interactors: The set of interactors that handle business logic.
    /// - Returns:
    ///     - A modified View with the DIContainer environment set.
    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        return inject(container)
    }
    
    /// Injects the DIContainer into the SwiftUI View.
    ///
    /// This method sets up the DIContainer in the SwiftUI environment, allowing
    /// child views to access the shared app state and interactors.
    ///
    /// - Parameters:
    ///    - container: The DIContainer instance to be injected.
    /// - Returns:
    ///     - A modified View with the DIContainer environment set.
    func inject(_ container: DIContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
