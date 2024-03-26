//
//  GluteExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct GluteExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Cable Pull Through",
            muscleGroup: .glutes,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Romanian Deadlift",
            muscleGroup: .glutes,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Glute Bridge",
            muscleGroup: .glutes,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Abduction Machine",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Hip Thrust",
            muscleGroup: .glutes,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Thrust Machine",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lateral Walk With Band",
            muscleGroup: .glutes,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Glute Kickbacks",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Romanian Deadlift",
            muscleGroup: .glutes,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Single Leg Romanian Deadlift",
            muscleGroup: .glutes,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Step Up",
            muscleGroup: .glutes,
            exerciseType: .bodyWeight
        )
    ]
}
