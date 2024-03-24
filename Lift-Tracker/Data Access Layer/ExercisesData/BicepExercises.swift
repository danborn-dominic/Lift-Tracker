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
            exerciseNotes: "Keep elbows close to the torso; curl the barbell up.",
            muscleGroup: .biceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Preacher Curl",
            exerciseNotes: "Perform curls using a preacher bench for arm isolation.",
            muscleGroup: .biceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bodyweight Curl",
            exerciseNotes: "Use a bar at hip height, curl body up keeping feet stationary.",
            muscleGroup: .biceps,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Curl With Bar",
            exerciseNotes: "Curl using a straight bar attached to the low pulley of a cable machine.",
            muscleGroup: .biceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Curl With Rope",
            exerciseNotes: "Use a rope attachment on a cable machine for curls.",
            muscleGroup: .biceps,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Concentration Curl",
            exerciseNotes: "Sit and rest elbow on the thigh; curl dumbbell up focusing on bicep contraction.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Curl",
            exerciseNotes: "Curl dumbbells while keeping upper arms stationary.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Preacher Curl",
            exerciseNotes: "Use preacher bench; curl dumbbells with controlled motion.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hammer Curl",
            exerciseNotes: "Curl dumbbells with palms facing each other.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Dumbbell Curl",
            exerciseNotes: "Curl with dumbbells while sitting back on an incline bench.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Bicep Curl",
            exerciseNotes: "Use a bicep curl machine for arm curls, maintaining proper form.",
            muscleGroup: .biceps,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Spider Curl",
            exerciseNotes: "Lean forward on an incline bench; perform curls.",
            muscleGroup: .biceps,
            exerciseType: .dumbbell
        )
    ]
}
