//
//  ChestExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/23/24.
//

import Foundation

struct ChestExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Dips",
            muscleGroup: .chest,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bench Press",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Chest Press",
            muscleGroup: .chest,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Decline Bench Press",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Chest Fly",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Bench Press",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Floor Press",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Bench Press",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Dumbbell Press",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Push-Up",
            muscleGroup: .chest,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Push-Up",
            muscleGroup: .chest,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Chest Fly",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Chest Press",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pec Deck",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push-Up",
            muscleGroup: .chest,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Smith Machine Bench Press",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Smith Machine Incline Bench Press",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Cable Chest Fly",
            muscleGroup: .chest,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Resistance Band Chest Fly",
            muscleGroup: .chest,
            exerciseType: .freeweight
        )
    ]
}
