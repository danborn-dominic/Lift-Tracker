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
            exerciseNotes: "Extend arms overhead, elbows close to head.",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Lying Triceps Extension",
            exerciseNotes: "Lie on back, extend arms upwards, keeping elbows fixed.",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bench Dip",
            exerciseNotes: "Lower body by bending arms, keeping elbows tight.",
            muscleGroup: .triceps,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Close-Grip Push-Up",
            exerciseNotes: "Hands closer than shoulder width, focus on triceps.",
            muscleGroup: .triceps,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Lying Triceps Extension",
            exerciseNotes: "Lie on bench, extend dumbbells overhead.",
            muscleGroup: .triceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Standing Triceps Extension",
            exerciseNotes: "Stand and extend dumbbells overhead.",
            muscleGroup: .triceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Overhead Cable Triceps Extension",
            exerciseNotes: "Stand, extend arms overhead using cable machine.",
            muscleGroup: .triceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Bodyweight Extension",
            exerciseNotes: "Extend arms to lift body in a prone position.",
            muscleGroup: .triceps,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Pushdown With Bar",
            exerciseNotes: "Push down against a bar on a cable machine.",
            muscleGroup: .triceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Pushdown With Rope",
            exerciseNotes: "Use rope attachment on cable machine for pushdowns.",
            muscleGroup: .triceps,
            exerciseType: .cable
        )
    ]
}
