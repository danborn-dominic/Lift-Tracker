//
//  BicepExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct BicepExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Curl",
            muscleGroup: .biceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Reverse Grip Barbell Curl",
            muscleGroup: .biceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Preacher Curl",
            muscleGroup: .biceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Bar Curl",
            muscleGroup: .biceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Rope Curl",
            muscleGroup: .biceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Concentration Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Preacher Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hammer Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Dumbbell Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Bicep Curl",
            muscleGroup: .biceps,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Spider Curl",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        )
    ]
}
