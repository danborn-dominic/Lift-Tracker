//
//  CalfExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct CalfExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Eccentric Heel Drop",
            exerciseNotes: "Slowly lower heels below the level of the step.",
            muscleGroup: .calves,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Heel Raise",
            exerciseNotes: "Raise heels as high as possible, then lower back down.",
            muscleGroup: .calves,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Calf Raise",
            exerciseNotes: "Sit and raise heels by pushing up with calf muscles.",
            muscleGroup: .calves,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Calf Raise",
            exerciseNotes: "Lift heels off the ground while standing.",
            muscleGroup: .calves,
            exerciseType: .bodyweight
        )
    ]
}
