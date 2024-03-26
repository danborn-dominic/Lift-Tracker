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
            muscleGroup: .calves,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Calf Raise",
            muscleGroup: .calves,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Calf Raise",
            muscleGroup: .calves,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Calf Raise",
            muscleGroup: .calves,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Single Leg Calf Raise",
            muscleGroup: .calves,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Calf Press",
            muscleGroup: .calves,
            exerciseType: .bodyWeight
        )
    ]
}
