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
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Wrist Curl Behind the Back",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bar Hang",
            muscleGroup: .forearms,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Wrist Curl",
            muscleGroup: .forearms,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Farmers Walk",
            muscleGroup: .forearms,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Wrist Extension",
            muscleGroup: .forearms,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Wrist Extension",
            muscleGroup: .forearms,
            exerciseType: .dumbbell
        )
    ]
}
