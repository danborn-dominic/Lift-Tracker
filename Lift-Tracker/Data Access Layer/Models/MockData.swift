//
//  MockData.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//
//  Description:
//  This file contains mock data to be used in previews.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation

#if DEBUG
extension Routine {
    static let testData: [Routine] = [
        Routine(id: UUID(), routineName: "Full Body", exercises: Exercise.testData),
        Routine(id: UUID(), routineName: "Upper Body", exercises: [Exercise.testData[0], Exercise.testData[1]]),
        Routine(id: UUID(), routineName: "Lower Body", exercises: [Exercise.testData[2]]),
        Routine(id: UUID(), routineName: "Push", exercises: [Exercise.testData[3]]),
        Routine(id: UUID(), routineName: "Pull", exercises: [Exercise.testData[4]]),
        Routine(id: UUID(), routineName: "Legs", exercises: [Exercise.testData[5]])
    ]
}

extension Exercise {
    static let testData: [Exercise] = [
        Exercise(
            id: UUID(),
            exerciseName: "Bench Press",
            exerciseNotes: "Keep elbows at 45 degrees.",
            maxWeight: 185,
            repsForMaxWeight: 5,
            muscleGroup: .chest,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Bent Over Rows",
            exerciseNotes: "Keep the back horizontal and use full range of motion.",
            maxWeight: 135,
            repsForMaxWeight: 8,
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Deadlift",
            exerciseNotes: "Keep your back straight and drive through the heels.",
            maxWeight: 300,
            repsForMaxWeight: 4,
            muscleGroup: .back,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Leg Press",
            exerciseNotes: "Do not lock your knees when extending.",
            maxWeight: 400,
            repsForMaxWeight: 6,
            muscleGroup: .quads,
            exerciseType: .machine
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Lunges",
            exerciseNotes: "Keep the knee in line with the foot.",
            maxWeight: 50,
            repsForMaxWeight: 10,
            muscleGroup: .quads,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Pull Ups",
            exerciseNotes: "Full range of motion from dead hang.",
            maxWeight: 0,
            repsForMaxWeight: 10,
            muscleGroup: .back,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Push Ups",
            exerciseNotes: "Keep body in a straight line throughout the movement.",
            maxWeight: 0,
            repsForMaxWeight: 20,
            muscleGroup: .chest,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Shoulder Press",
            exerciseNotes: "Press overhead to full extension.",
            maxWeight: 95,
            repsForMaxWeight: 8,
            muscleGroup: .shoulders,
            exerciseType: .dumbbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Sit Ups",
            exerciseNotes: "Keep feet anchored and use a full range of motion.",
            maxWeight: 0,
            repsForMaxWeight: 15,
            muscleGroup: .core,
            exerciseType: .bodyWeight
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Squats",
            exerciseNotes: "Depth below parallel.",
            maxWeight: 225,
            repsForMaxWeight: 5,
            muscleGroup: .quads,
            exerciseType: .barbell
        ),
        Exercise(
            id: UUID(),
            exerciseName: "Tricep Dips",
            exerciseNotes: "Lower until shoulders are just below the elbows.",
            maxWeight: 0,
            repsForMaxWeight: 12,
            muscleGroup: .triceps,
            exerciseType: .bodyWeight
        )
    ].sorted(by: { $0.exerciseName < $1.exerciseName }) // Sort the array by exercise name
}
#endif
