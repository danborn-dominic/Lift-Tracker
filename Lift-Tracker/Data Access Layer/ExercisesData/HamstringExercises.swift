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
                    exerciseNotes: "Perform curl movement using bodyweight.",
                    muscleGroup: .hamstrings,
                    exerciseType: .bodyweight
                ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Leg Curl",
            exerciseNotes: "Use the seated leg curl machine for hamstrings.",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Romanian Deadlift",
            exerciseNotes: "Keep your legs relatively straight, hinge at the hips.",
            muscleGroup: .hamstrings,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Leg Curl",
            exerciseNotes: "Use the lying leg curl machine to target hamstrings.",
            muscleGroup: .hamstrings,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Leg Curl On Ball",
            exerciseNotes: "Use a stability ball to perform leg curls.",
            muscleGroup: .hamstrings,
            exerciseType: .bodyweight
        ),
    ]
}
