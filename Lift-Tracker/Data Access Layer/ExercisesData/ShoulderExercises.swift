//
//  ShoulderExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/23/24.
//

import Foundation

struct ShoulderExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Band External Shoulder Rotation",
            exerciseNotes: "Keep elbow fixed and rotate shoulder outward.",
            muscleGroup: .shoulders,
            exerciseType: .other
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Band Internal Shoulder Rotation",
            exerciseNotes: "Stabilize elbow and rotate shoulder inward against band resistance.",
            muscleGroup: .shoulders,
            exerciseType: .other
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Front Raise",
            exerciseNotes: "Lift the barbell to shoulder height, keeping arms straight.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Rear Delt Row",
            exerciseNotes: "Bend forward slightly and pull barbell towards hips.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Upright Row",
            exerciseNotes: "Lift the barbell close to the body, elbows leading.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Behind the Neck Press",
            exerciseNotes: "Press the bar from behind the neck to overhead.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Lateral Raise",
            exerciseNotes: "Raise arms to the side, maintaining straight elbows.",
            muscleGroup: .shoulders,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Rear Delt Row",
            exerciseNotes: "Pull with elbows high, focus on rear deltoids.",
            muscleGroup: .shoulders,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Front Raise",
            exerciseNotes: "Lift dumbbells in front of you with straight arms.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Horizontal Internal Shoulder Rotation",
            exerciseNotes: "Rotate the arms internally at shoulder level.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Horizontal External Shoulder Rotation",
            exerciseNotes: "Rotate the arms externally at shoulder level.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Lateral Raise",
            exerciseNotes: "Raise arms to the sides, keeping elbows slightly bent.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Rear Delt Row",
            exerciseNotes: "Focus on pulling with the rear deltoids.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Shoulder Press",
            exerciseNotes: "Press the dumbbells overhead without locking elbows.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Face Pull",
            exerciseNotes: "Pull the rope towards the face, keeping elbows high.",
            muscleGroup: .shoulders,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Front Hold",
            exerciseNotes: "Hold a weight plate in front with arms extended.",
            muscleGroup: .shoulders,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Dumbbell External Shoulder Rotation",
            exerciseNotes: "Lie on side and rotate the arm outward holding a dumbbell.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Dumbbell Internal Shoulder Rotation",
            exerciseNotes: "Lie on side and rotate the arm inward holding a dumbbell.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Lateral Raise",
            exerciseNotes: "Raise arms out to the sides using the machine.",
            muscleGroup: .shoulders,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Shoulder Press",
            exerciseNotes: "Press overhead using the shoulder press machine.",
            muscleGroup: .shoulders,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Monkey Row",
            exerciseNotes: "Row with dumbbells alternating like a monkey motion.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Overhead Press",
            exerciseNotes: "Press the barbell overhead from shoulder level.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Plate Front Raise",
            exerciseNotes: "Lift a weight plate up in front of you with arms extended.",
            muscleGroup: .shoulders,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Power Jerk",
            exerciseNotes: "Explosively lift the barbell overhead.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push Press",
            exerciseNotes: "Start with a slight knee bend and then explosively press overhead.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Reverse Cable Flyes",
            exerciseNotes: "Pull the cables outward and back, focusing on rear deltoids.",
            muscleGroup: .shoulders,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Reverse Dumbbell Flyes",
            exerciseNotes: "Bend forward and lift dumbbells outward.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Reverse Machine Fly",
            exerciseNotes: "Sit in the reverse fly machine and move arms outward.",
            muscleGroup: .shoulders,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Dumbbell Shoulder Press",
            exerciseNotes: "Press the dumbbells overhead while seated.",
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Barbell Overhead Press",
            exerciseNotes: "Perform a shoulder press with a barbell while seated.",
            muscleGroup: .shoulders,
            exerciseType: .barbell
        )
    ]
}
