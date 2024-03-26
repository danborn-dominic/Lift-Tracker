//
//  QuadsExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct QuadsExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Bodyweight Squat",
            muscleGroup: .quads,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Lunge",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Walking Lunge",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Belt Squat",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Body Weight Lunge",
            muscleGroup: .quads,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Box Squat",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bulgarian Split Squat",
            muscleGroup: .quads,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Lunge",
            exerciseNotes: "Maintain balance and proper form.",
            muscleGroup: .quads,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Squat",
            exerciseNotes: "Keep dumbbells at sides, squat to depth.",
            muscleGroup: .quads,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Front Squat",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Back Squat",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Goblet Squat",
            muscleGroup: .quads,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hack Squat",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Adduction Machine",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Landmine Squat",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Leg Extension",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Leg Press",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pause Squat",
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Smith Machine Squat",
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Squat",
            muscleGroup: .quads,
            exerciseType: .bodyWeight
        )
    ]
}
