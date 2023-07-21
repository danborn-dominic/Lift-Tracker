//
//  DependencyInjector.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import SwiftUI
import Combine

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {

    let appState: WorkoutStore<AppState>
    let interactors: Interactors

    init(appState: WorkoutStore<AppState>, interactors: Interactors) {
        print("INFO initializing the DIContainer")
        self.appState = appState
        self.interactors = interactors
    }

    static var defaultValue: DIContainer {
        // Provide a default value
        let appState = WorkoutStore<AppState>(AppState())
        let interactors = Interactors.stub
        return DIContainer(appState: appState, interactors: interactors)
    }
}

extension EnvironmentValues {
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

    func inject(_ appState: AppState,
                _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState),
                                    interactors: interactors)
        return inject(container)
    }

    func inject(_ container: DIContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
