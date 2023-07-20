//
//  InteractorsContainer.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

extension DIContainer {
    struct Interactors {
        let workoutInteractor: WorkoutInteractor

        init(workoutInteractor: WorkoutInteractor) {
            self.workoutInteractor = workoutInteractor
        }

    }
}

extension DIContainer.Interactors {
    static var stub: DIContainer.Interactors {
        let workoutInteractor = StubWorkoutInteractor()
        return DIContainer.Interactors(workoutInteractor: workoutInteractor)
    }
}

