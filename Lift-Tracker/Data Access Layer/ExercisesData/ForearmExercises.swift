//
//  ForearmExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct ForearmExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Wrist Curl",
            exerciseNotes: "Curl the barbell towards your forearm, focusing on wrist movement.",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Wrist Curl Behind the Back",
            exerciseNotes: "Hold the barbell behind your back and perform wrist curls.",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bar Hang",
            exerciseNotes: "Hang from a bar to improve grip strength.",
            muscleGroup: .forearms,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Wrist Curl",
            exerciseNotes: "Use dumbbells for wrist curls to isolate each wrist.",
            muscleGroup: .forearms,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Farmers Walk",
            exerciseNotes: "Carry heavy weights in each hand, maintaining a strong grip.",
            muscleGroup: .forearms,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Fat Bar Deadlift",
            exerciseNotes: "Perform a deadlift with a thicker bar to challenge grip strength.",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Gripper",
            exerciseNotes: "Use a hand gripper to strengthen grip and forearm muscles.",
            muscleGroup: .forearms,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "One-Handed Bar Hang",
            exerciseNotes: "Hang from a bar using one hand to increase grip strength.",
            muscleGroup: .forearms,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Plate Pinch",
            exerciseNotes: "Hold weight plates in a pinch grip to build forearm strength.",
            muscleGroup: .forearms,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Plate Wrist Curl",
            exerciseNotes: "Perform wrist curls holding a weight plate.",
            muscleGroup: .forearms,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Towel Pull-Up",
            exerciseNotes: "Perform pull-ups gripping a towel to engage forearm muscles.",
            muscleGroup: .forearms,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Wrist Extension",
            exerciseNotes: "Extend the wrist upwards while holding a barbell.",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Wrist Extension",
            exerciseNotes: "Lift the back of the hand towards the ceiling while holding a dumbbell.",
            muscleGroup: .forearms,
            exerciseType: .dumbbell
        )
    ]
}
