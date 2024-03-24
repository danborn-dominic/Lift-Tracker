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
            exerciseName: "Bar Dip",
            exerciseNotes: "Lean forward slightly to engage chest muscles more intensely.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bench Press",
            exerciseNotes: "Keep elbows at 45 degrees to the torso.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Chest Press",
            exerciseNotes: "Push hands together while extending arms for peak contraction.",
            muscleGroup: .chest,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Close-Grip Bench Press",
            exerciseNotes: "Keep the grip shoulder-width to emphasize the triceps.",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Close-Grip Feet-Up Bench Press",
            exerciseNotes: "Elevate feet to increase core activation.",
            muscleGroup: .triceps,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Decline Bench Press",
            exerciseNotes: "Focus on the lower chest, keep the decline angle at 15-30 degrees.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Chest Fly",
            exerciseNotes: "Keep a slight bend in the elbows while performing.",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Chest Press",
            exerciseNotes: "Press the weights up with control; don't lock out the elbows.",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Pullover",
            exerciseNotes: "Focus on stretching the chest at the bottom of the movement.",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Feet-Up Bench Press",
            exerciseNotes: "Place feet on bench to increase core engagement.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Floor Press",
            exerciseNotes: "Pause when upper arms touch the ground.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Bench Press",
            exerciseNotes: "Set bench to a 30-45 degree angle.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Dumbbell Press",
            exerciseNotes: "Press up with elbows out to the sides.",
            muscleGroup: .chest,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Incline Push-Up",
            exerciseNotes: "Elevate feet; body straight.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kettlebell Floor Press",
            exerciseNotes: "Press kettlebells from the floor to straight arms.",
            muscleGroup: .chest,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Incline Push-Up",
            exerciseNotes: "Incline push-up position, but from the knees.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Push-Up",
            exerciseNotes: "Perform push-ups from the knees.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Chest Fly",
            exerciseNotes: "Keep a slight bend in elbows throughout.",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Chest Press",
            exerciseNotes: "Push plates forward in a smooth motion.",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pec Deck",
            exerciseNotes: "Squeeze chest at the peak of the motion.",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pin Bench Press",
            exerciseNotes: "Set safety pins at chest level.",
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push-Up",
            exerciseNotes: "Keep body in a straight line.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push-Up Against Wall",
            exerciseNotes: "Stand arm's length from wall; lean and push.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push-Ups With Feet in Rings",
            exerciseNotes: "Feet suspended in rings; perform push-ups.",
            muscleGroup: .chest,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Resistance Band Chest Fly",
            exerciseNotes: "Maintain tension on the band throughout.",
            muscleGroup: .chest,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Smith Machine Bench Press",
            exerciseNotes: "Controlled motion, avoid locking elbows.",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Smith Machine Incline Bench Press",
            exerciseNotes: "Set bench to a 45-degree angle.",
            muscleGroup: .chest,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Cable Chest Fly",
            exerciseNotes: "Control the motion; squeeze chest at the end.",
            muscleGroup: .chest,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Resistance Band Chest Fly",
            exerciseNotes: "Keep tension on the band; move arms in a wide arc.",
            muscleGroup: .chest,
            exerciseType: .freeweight
        )
    ]
}
