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
            exerciseName: "Banded Side Kicks",
            exerciseNotes: "Using a resistance band, perform side leg raises.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Pull Through",
            exerciseNotes: "Face away from the machine, pull the cable through legs.",
            muscleGroup: .glutes,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Clamshells",
            exerciseNotes: "Lying on side, raise top knee while keeping feet together.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Romanian Deadlift",
            exerciseNotes: "Hinge at hips, keeping legs straight, with dumbbells in hand.",
            muscleGroup: .glutes,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Frog Pumps",
            exerciseNotes: "Lay on back, soles of feet together, and raise hips with dumbbell on pelvis.",
            muscleGroup: .glutes,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Fire Hydrants",
            exerciseNotes: "On all fours, raise knee out to the side like a dog at a fire hydrant.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Frog Pumps",
            exerciseNotes: "Lay on back, soles of feet together, and rapidly pump hips upwards.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Glute Bridge",
            exerciseNotes: "Lay on back, feet flat, and lift hips off the ground.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Abduction Against Band",
            exerciseNotes: "With band around thighs, stand and move legs outward against resistance.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Abduction Machine",
            exerciseNotes: "Sit in machine and push legs outward against resistance.",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Thrust",
            exerciseNotes: "Focus on driving through the heels to lift the hips.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Thrust Machine",
            exerciseNotes: "Use the machine to target the glutes with controlled movement.",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hip Thrust With Band Around Knees",
            exerciseNotes: "Keep tension on the band while performing the hip thrust.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lateral Walk With Band",
            exerciseNotes: "Maintain constant tension on the band while walking sideways.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Glute Kickbacks",
            exerciseNotes: "Use the machine to perform kickbacks, focusing on glute activation.",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "One-Legged Glute Bridge",
            exerciseNotes: "Perform a glute bridge with one leg, driving through the heel.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "One-Legged Hip Thrust",
            exerciseNotes: "Single-leg thrusts for focused glute engagement.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Romanian Deadlift",
            exerciseNotes: "Hinge at the hips with a slight knee bend, focusing on hamstring and glute stretch.",
            muscleGroup: .glutes,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Single Leg Romanian Deadlift",
            exerciseNotes: "Perform a Romanian deadlift on one leg for balance and focused muscle work.",
            muscleGroup: .glutes,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Standing Glute Kickback in Machine",
            exerciseNotes: "Kick back against resistance, focusing on squeezing the glutes.",
            muscleGroup: .glutes,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Step Up",
            exerciseNotes: "Step onto a raised platform, focusing on driving through the lead leg.",
            muscleGroup: .glutes,
            exerciseType: .bodyweight
        )
    ]
}
