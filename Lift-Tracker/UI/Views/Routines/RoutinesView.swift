//
//  RoutinesView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

struct RoutinesView: View {
    
    private let container: DIContainer
    @State private(set) var routines: Loadable<[RoutineStruct]> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
        self._routines = .init(initialValue: routines)
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Routines")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddRoutineView(container:container)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear(perform: loadRoutines)
            .onReceive(routinesUpdate) { routines in
                switch routines {
                case .notRequested:
                    self.routines = .notRequested
                case .isLoading(let last, _):
                    self.routines = .isLoading(last: last, cancelBag: CancelBag())
                case .loaded(let routines):
                    self.routines = .loaded(routines)
                case .failed(let error):
                    self.routines = .failed(error)
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        switch routines {
        case .notRequested: notRequestedView
        case .isLoading(_, _): loadingView
        case let .loaded(routines): loadedView(routines)
        case let .failed(error): failedView(error)
        }
    }
}
// MARK: - Side Effects
private extension RoutinesView {
    var routinesUpdate: AnyPublisher<Loadable<[RoutineStruct]>, Never> {
        container.appState.updates(for: \.userData.routines)
    }
}
// MARK: - Routing
extension RoutinesView {
    struct Routing: Equatable {
        var routineDetails: RoutineStruct.ID?
    }
}
// MARK: - Managing Content
private extension RoutinesView {
    var notRequestedView: some View {
        Text("").onAppear(perform: loadRoutines)
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load routines: \(error.localizedDescription)")
            .onTapGesture { self.loadRoutines() }
    }
    
    func loadRoutines() {
        container.interactors.routineInteractor
            .loadRoutines()
    }
    
    func deleteRoutine(at offsets: IndexSet) {
        let routinesToDelete = offsets.lazy.map { self.routines.value?[$0] }
        routinesToDelete.forEach { routine in
            if let routine = routine {
                container.interactors.routineInteractor.deleteRoutine(routine: routine)
            }
        }
    }
}

// MARK: - Displaying Content
private extension RoutinesView {
    func loadedView(_ routines: [RoutineStruct]) -> some View {
        if routines.isEmpty {
            return AnyView(Text("No routines"))
        } else {
            return AnyView(List {
                ForEach(routines, id: \.id) { routine in
                    NavigationLink(destination: RoutineDetailView(routine: routine)) {
                        Text(routine.routineName)
                    }
                }
                .onDelete(perform: deleteRoutine)
            })
        }
    }
}

#if DEBUG
struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        return RoutinesView(container: .preview)
    }
}
#endif
