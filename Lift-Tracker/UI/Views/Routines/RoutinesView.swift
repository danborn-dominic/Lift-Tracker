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
    @State private(set) var workouts: Loadable<[RoutineStruct]> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
        self._workouts = .init(initialValue: workouts)
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
            .onAppear(perform: loadWorkouts)
            .onReceive(workoutsUpdate) { workouts in
                switch workouts {
                case .notRequested:
                    self.workouts = .notRequested
                case .isLoading(let last, _):
                    self.workouts = .isLoading(last: last, cancelBag: CancelBag())
                case .loaded(let workouts):
                    self.workouts = .loaded(workouts)
                case .failed(let error):
                    self.workouts = .failed(error)
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        switch workouts {
        case .notRequested: notRequestedView
        case .isLoading(_, _): loadingView
        case let .loaded(workouts): loadedView(workouts)
        case let .failed(error): failedView(error)
        }
    }
}
// MARK: - Side Effects
private extension RoutinesView {
    var workoutsUpdate: AnyPublisher<Loadable<[RoutineStruct]>, Never> {
        container.appState.updates(for: \.userData.routines)
    }
}
// MARK: - Routing
extension RoutinesView {
    struct Routing: Equatable {
        var workoutDetails: RoutineStruct.ID?
    }
}
// MARK: - Managing Content
private extension RoutinesView {
    var notRequestedView: some View {
        Text("").onAppear(perform: loadWorkouts)
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load workouts: \(error.localizedDescription)")
            .onTapGesture { self.loadWorkouts() }
    }
    
    func loadWorkouts() {
        container.interactors.routineInteractor
            .loadRoutines()
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        let routinesToDelete = offsets.lazy.map { self.workouts.value?[$0] }
        routinesToDelete.forEach { routine in
            if let routine = routine {
                container.interactors.routineInteractor.deleteRoutine(routine: routine)
            }
        }
    }
}

// MARK: - Displaying Content
private extension RoutinesView {
    func loadedView(_ workouts: [RoutineStruct]) -> some View {
        if workouts.isEmpty {
            return AnyView(Text("No routines"))
        } else {
            return AnyView(List {
                ForEach(workouts, id: \.id) { workout in
                    NavigationLink(destination: RoutineDetailView(workout: workout)) {
                        Text(workout.routineName)
                    }
                }
                .onDelete(perform: deleteWorkout)
            })
        }
    }
}

#if DEBUG
struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        return RoutinesView(container: .preview)
    }
}
#endif
