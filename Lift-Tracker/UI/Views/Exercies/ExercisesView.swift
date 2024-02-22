//
//  ExercisesView.swift
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

struct ExercisesView: View {
    
    private let container: DIContainer
    @State private(set) var exercisesLibrary: Loadable<ExerciseLibraryStruct> = .notRequested
    
    init(container: DIContainer) {
        self.container = container
        self._exercisesLibrary = .init(initialValue: exercisesLibrary)
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Exercises")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                                    AddExerciseView(container:container)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear(perform: loadExercises)
            .onReceive(exercisesUpdate) { exercises in
                switch exercises {
                case .notRequested:
                    self.exercisesLibrary = .notRequested
                case .isLoading(let last, _):
                    self.exercisesLibrary = .isLoading(last: last, cancelBag: CancelBag())
                case .loaded(let routines):
                    self.exercisesLibrary = .loaded(routines)
                case .failed(let error):
                    self.exercisesLibrary = .failed(error)
                }
            }
        
    }
    
    @ViewBuilder private var content: some View {
        switch exercisesLibrary {
        case .notRequested: notRequestedView
        case .isLoading(_, _): loadingView
        case let .loaded(exercisesLibrary): loadedView(exercisesLibrary)
        case let .failed(error): failedView(error)
        }
    }
}

// MARK: - Side Effects
private extension ExercisesView {
    var exercisesUpdate: AnyPublisher<Loadable<ExerciseLibraryStruct>, Never> {
        container.appState.updates(for: \.userData.exerciseLibrary)
    }
}
// MARK: - Routing
extension ExercisesView {
    struct Routing: Equatable {
        var exerciseDetails: ExerciseStruct.ID?
    }
}
// MARK: - Managing Content
private extension ExercisesView {
    var notRequestedView: some View {
        Text("Not Requested View").onAppear(perform: loadExercises)
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load routines: \(error.localizedDescription)")
            .onTapGesture { self.loadExercises() }
    }
    
    func loadExercises() {
        container.interactors.exerciseInteractor
            .loadExercises()
    }
    
    func deleteExercise(at offsets: IndexSet) {
        guard let exercises = exercisesLibrary.value?.exercises else { return }
        offsets.forEach { index in
            if index < exercises.count {
                let exerciseToDelete = exercises[index]
                container.interactors.exerciseInteractor.deleteExercise(exercise: exerciseToDelete)
            }
        }
    }
}

// MARK: - Displaying Content
private extension ExercisesView {
    func loadedView(_ exerciseLibrary: ExerciseLibraryStruct) -> some View {
        let exercises = exerciseLibrary.exercises
        if exercises.isEmpty {
            return AnyView(Text("No exercises"))
        } else {
            return AnyView(List {
                ForEach(exercises, id: \.id) { exercise in
                    Text(exercise.exerciseName)
                }
                .onDelete(perform: deleteExercise)
            })
        }
    }
}

#if DEBUG
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(container: .preview)
    }
}
#endif
