//
//  WorkoutList.swift
//  WorkoutApp
//
//  Created by Your Name on Today's Date.
//  Copyright (c) 2023 Your Name. All rights reserved.
//

import SwiftUI
import Combine

struct WorkoutListView: View {

    @State private(set) var workouts: Loadable<[WorkoutStruct]> = .notRequested
    @Environment(\.injected) private var injected: DIContainer

    init(workouts: Loadable<[WorkoutStruct]> = .notRequested) {
        self._workouts = .init(initialValue: workouts)
    }

    var body: some View {
        NavigationView {
            self.content
                .navigationBarTitle("Workouts")
                .navigationBarItems(trailing: NavigationLink(destination: AddWorkoutView()) {
                Image(systemName: "plus")
            })
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
        let _ = print("idk ", workouts)
        switch workouts {
        case .notRequested: notRequestedView
        case .isLoading(_, _): loadingView
        case let .loaded(workouts): loadedView(workouts)
        case let .failed(error): failedView(error)
        }
    }
}

// MARK: - Side Effects

private extension WorkoutListView {
    var workoutsUpdate: AnyPublisher<Loadable<[WorkoutStruct]>, Never> {
        injected.appState.updates(for: \.userData.workouts)
    }
}

// MARK: - Routing

extension WorkoutListView {
    struct Routing: Equatable {
        var workoutDetails: WorkoutStruct.ID?
    }
}

// MARK: - Managing Content

private extension WorkoutListView {
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
        print("INFO called load workouts in view")
        injected.interactors.workoutInteractor
            .loadWorkouts()
    }

    func deleteWorkout(at offsets: IndexSet) {
        let workoutsToDelete = offsets.lazy.map { self.workouts.value?[$0] }
        workoutsToDelete.forEach { workout in
            if let workout = workout {
                injected.interactors.workoutInteractor.deleteWorkout(workout: workout)
            }
        }
    }
}

// MARK: - Displaying Content

private extension WorkoutListView {
    func loadedView(_ workouts: [WorkoutStruct]) -> some View {
//        Text("test")
        List {
            ForEach(workouts, id: \.id) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    Text(workout.name)
                }
            }
                .onDelete(perform: deleteWorkout)
        }
    }
}

#if DEBUG
    struct WorkoutList_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutListView(workouts: .loaded(WorkoutStruct.mockedData))
                .inject(.preview)
        }
    }
#endif
