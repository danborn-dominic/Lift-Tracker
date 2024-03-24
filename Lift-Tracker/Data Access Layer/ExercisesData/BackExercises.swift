//
//  BackExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct BackExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Assisted Chin-Up",
            exerciseNotes: "Use an assistance machine or band to aid in chin-ups.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Assisted Pull-Up",
            exerciseNotes: "Perform pull-ups with assistance from a machine or band.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Back Extension",
            exerciseNotes: "Use a back extension bench to target lower back muscles.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Banded Muscle-Up",
            exerciseNotes: "Use a resistance band to assist with muscle-ups.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Row",
            exerciseNotes: "Bend forward and pull the barbell towards your waist.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Barbell Shrug",
            exerciseNotes: "Lift shoulders up towards the ears while holding a barbell.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Block Clean",
            exerciseNotes: "Lift the barbell from blocks, focusing on explosive power.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Block Snatch",
            exerciseNotes: "Perform a snatch lift starting from blocks.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Close Grip Seated Row",
            exerciseNotes: "Pull the cable towards your waist using a close grip.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Wide Grip Seated Row",
            exerciseNotes: "Perform seated rows with a wide grip on the cable.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Chin-Up",
            exerciseNotes: "Pull yourself up until your chin is over the bar.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Clean",
            exerciseNotes: "Lift the barbell from the floor to a racked position on the shoulders.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Clean and Jerk",
            exerciseNotes: "Perform a clean followed by an overhead jerk.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Deadlift",
            exerciseNotes: "Lift the barbell from the ground to hip level then return it to the floor.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Deficit Deadlift",
            exerciseNotes: "Perform a deadlift standing on an elevated surface to increase the range of motion.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Deadlift",
            exerciseNotes: "Perform a deadlift using dumbbells instead of a barbell.",
            muscleGroup: .back,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Row",
            exerciseNotes: "Pull the dumbbell towards your waist, one arm at a time.",
            muscleGroup: .back,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dumbbell Shrug",
            exerciseNotes: "Lift your shoulders up towards your ears while holding dumbbells.",
            muscleGroup: .back,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Floor Back Extension",
            exerciseNotes: "Lie face down and lift your upper body off the floor.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Good Morning",
            exerciseNotes: "Bend at your hips while keeping your back straight and legs relatively straight.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hang Clean",
            exerciseNotes: "Begin with the barbell at the knees and execute a clean.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hang Power Clean",
            exerciseNotes: "Perform a power clean starting from the 'hang' position.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hang Power Snatch",
            exerciseNotes: "Lift the barbell from a hanging position directly overhead.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hang Snatch",
            exerciseNotes: "Perform a snatch lift starting from the hang position.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Inverted Row",
            exerciseNotes: "Pull your chest up to the bar using a horizontal rowing motion.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Inverted Row with Underhand Grip",
            exerciseNotes: "Perform an inverted row with palms facing towards you.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Jefferson Curl",
            exerciseNotes: "Slowly curl downward with weight, focusing on spinal flexion.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Jumping Muscle-Up",
            exerciseNotes: "Jump to assist the muscle-up movement on a bar or rings.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kettlebell Swing",
            exerciseNotes: "Swing the kettlebell between your legs and up to chest level.",
            muscleGroup: .back,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lat Pulldown With Pronated Grip",
            exerciseNotes: "Pull the bar down in front of you with palms facing away.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lat Pulldown With Supinated Grip",
            exerciseNotes: "Perform lat pulldowns with palms facing towards you.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Muscle-Up (Bar)",
            exerciseNotes: "Pull-up followed by a transition to a dip on the bar.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Muscle-Up (Rings)",
            exerciseNotes: "Perform a muscle-up using gymnastics rings.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "One-Handed Cable Row",
            exerciseNotes: "Row with one hand at a time using the cable machine.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "One-Handed Lat Pulldown",
            exerciseNotes: "Perform lat pulldowns with one hand at a time.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pause Deadlift",
            exerciseNotes: "Pause midway during the deadlift before completing the lift.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pendlay Row",
            exerciseNotes: "Row the barbell from the floor to your chest in a bent-over position.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Power Clean",
            exerciseNotes: "Explosively lift the barbell from the floor to your shoulders.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Power Snatch",
            exerciseNotes: "Lift the barbell overhead in one smooth, rapid movement.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pull-Up",
            exerciseNotes: "Pull yourself up until your chin is above the bar, focusing on upper back muscles.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pull-Up With a Neutral Grip",
            exerciseNotes: "Perform pull-ups with hands facing each other.",
            muscleGroup: .back,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Rack Pull",
            exerciseNotes: "Deadlift the barbell from a rack at knee height.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seal Row",
            exerciseNotes: "Lie face down on a bench and row a barbell or dumbbells.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Seated Machine Row",
            exerciseNotes: "Use a rowing machine to target the mid to upper back.",
            muscleGroup: .back,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Snatch",
            exerciseNotes: "Lift the barbell from the floor to overhead in one motion.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Snatch Grip Deadlift",
            exerciseNotes: "Deadlift with a wide grip used in Olympic snatching.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Stiff-Legged Deadlift",
            exerciseNotes: "Deadlift focusing on hamstring and lower back engagement.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Straight Arm Lat Pulldown",
            exerciseNotes: "Pull the bar down with arms straight to target the lats.",
            muscleGroup: .back,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Sumo Deadlift",
            exerciseNotes: "Wide stance deadlift focusing on glutes and hamstrings.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "T-Bar Row",
            exerciseNotes: "Row a T-bar loaded with weight, keeping your back straight.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Trap Bar Deadlift With High Handles",
            exerciseNotes: "Deadlift using a trap bar which allows for a more upright posture.",
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Trap Bar Deadlift With Low Handles",
            exerciseNotes: "Perform deadlifts with a trap bar using its lower handles.",
            muscleGroup: .back,
            exerciseType: .barbell
        )
    ]
}
