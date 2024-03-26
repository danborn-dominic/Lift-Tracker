//
//  TricepExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct TricepExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Standing Triceps Extension",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Lying Triceps Extension",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bench Dip",
            muscleGroup: .triceps,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Close-Grip Push-Up",
            muscleGroup: .triceps,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Lying Triceps Extension",
            muscleGroup: .triceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Standing Triceps Extension",
            muscleGroup: .triceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Overhead Cable Triceps Extension",
            muscleGroup: .triceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Bar Pushdown",
            muscleGroup: .triceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Extension",
            muscleGroup: .triceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Close-Grip Bench Press",
            muscleGroup: .triceps,
            exerciseType: .barbell
        )
    ]
}
