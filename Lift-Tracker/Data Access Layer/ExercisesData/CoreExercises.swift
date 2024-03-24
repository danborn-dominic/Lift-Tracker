//
//  CoreExercises.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/24/24.
//

import Foundation

struct CoreExercises {
    static let data: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Ball Slams",
            exerciseNotes: "Slam the ball to the ground using your core strength.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Cable Crunch",
            exerciseNotes: "Kneel and crunch downwards using the cable resistance.",
            muscleGroup: .core,
            exerciseType: .cable
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Crunch",
            exerciseNotes: "Lie on your back and lift your upper body towards your knees.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Dead Bug",
            exerciseNotes: "Lie on your back and extend your opposite arm and leg.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hanging Leg Raise",
            exerciseNotes: "Raise your legs while hanging from a bar.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hanging Knee Raise",
            exerciseNotes: "Raise your knees while hanging from a bar.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Hanging Sit-Up",
            exerciseNotes: "Perform a sit-up while hanging upside down.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "High to Low Wood Chop with Band",
            exerciseNotes: "Perform a diagonal chopping motion using a resistance band.",
            muscleGroup: .core,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Horizontal Wood Chop with Band",
            exerciseNotes: "Perform a horizontal chopping motion using a resistance band.",
            muscleGroup: .core,
            exerciseType: .freeweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Ab Wheel Roll-Out",
            exerciseNotes: "Roll the ab wheel forward while kneeling.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Plank",
            exerciseNotes: "Hold a plank position from your knees.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Kneeling Side Plank",
            exerciseNotes: "Perform a side plank while kneeling.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Leg Raise",
            exerciseNotes: "Raise your legs while lying on your back.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Windshield Wiper",
            exerciseNotes: "Rotate your legs side to side while lying on your back.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lying Windshield Wiper with Bent Knees",
            exerciseNotes: "Perform windshield wipers with bent knees.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Machine Crunch",
            exerciseNotes: "Use a crunch machine for abdominal contraction.",
            muscleGroup: .core,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Mountain Climbers",
            exerciseNotes: "Perform a running motion in a plank position.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Oblique Crunch",
            exerciseNotes: "Crunch to the side to target oblique muscles.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Oblique Sit-Up",
            exerciseNotes: "Perform a sit-up with a twist to target the obliques.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Plank",
            exerciseNotes: "Maintain a straight line from head to heels, engaging the core.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Plank with Leg Lifts",
            exerciseNotes: "Lift one leg at a time while holding the plank position.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Side Plank",
            exerciseNotes: "Balance on one arm, keeping your body in a straight line.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Sit-Up",
            exerciseNotes: "Lie on your back and lift your torso to your thighs, engaging your abdominal muscles.",
            muscleGroup: .core,
            exerciseType: .bodyweight
        )
    ]
}
