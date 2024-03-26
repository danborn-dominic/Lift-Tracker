//
//  HamstringExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct HamstringExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Bodyweight Leg Curl",
            muscleGroup: .hamstrings,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Ball Leg Curl",
            muscleGroup: .hamstrings,
            exerciseType: .other
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Leg Curl",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Romanian Deadlift",
            muscleGroup: .hamstrings,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Romanian Deadlift",
            muscleGroup: .hamstrings,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Single Leg Romanian Deadlift",
            muscleGroup: .hamstrings,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Stiff Legged Deadlift",
            muscleGroup: .hamstrings,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Leg Curl",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kettlebell Swing",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Good Morning",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        )
    ]
}
