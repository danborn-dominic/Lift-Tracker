//
//  InteractorsContainer.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

extension DIContainer {
    struct Interactors {
        let workoutInteractor: WorkoutInteractor
        let exerciseInteractor: ExerciseInteractor

        init(workoutInteractor: WorkoutInteractor, exerciseInteractor: ExerciseInteractor) {
            self.workoutInteractor = workoutInteractor
            self.exerciseInteractor = exerciseInteractor
        }

    }
}

extension DIContainer.Interactors {
    static var stub: DIContainer.Interactors {
        let workoutInteractor = StubWorkoutInteractor()
        let exerciseInteractor = StubExerciseInteractor()
        return DIContainer.Interactors(workoutInteractor: workoutInteractor, exerciseInteractor: exerciseInteractor)
    }
}

