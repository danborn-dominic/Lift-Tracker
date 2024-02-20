//
//  MockData.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import Foundation

#if DEBUG
extension WorkoutStruct {
    static let mockData: [WorkoutStruct] = [
        WorkoutStruct(workoutName: "Full Body Workout", id: UUID(), exercises: ExerciseStruct.mockData),
        WorkoutStruct(workoutName: "Upper Body Workout", id: UUID(), exercises: [ExerciseStruct.mockData[0], ExerciseStruct.mockData[1]]),
        WorkoutStruct(workoutName: "Lower Body Workout", id: UUID(), exercises: [ExerciseStruct.mockData[2]]),
        WorkoutStruct(workoutName: "Push Workout", id: UUID(), exercises: [ExerciseStruct.mockData[3]]),
        WorkoutStruct(workoutName: "Pull Workout", id: UUID(), exercises: [ExerciseStruct.mockData[4]]),
        WorkoutStruct(workoutName: "Legs Workout", id: UUID(), exercises: [ExerciseStruct.mockData[5]])
    ]
}

extension ExerciseStruct {
    static let mockData: [ExerciseStruct] = [
        ExerciseStruct(id: UUID(), exerciseName: "Bench Press", sets: SetStruct.mockData),
        ExerciseStruct(id: UUID(), exerciseName: "Pull Ups", sets: SetStruct.mockData),
        ExerciseStruct(id: UUID(), exerciseName: "Squats", sets: SetStruct.mockData),
        ExerciseStruct(id: UUID(), exerciseName: "Shoulder Press", sets: SetStruct.mockData),
        ExerciseStruct(id: UUID(), exerciseName: "Bent Over Rows", sets: SetStruct.mockData),
        ExerciseStruct(id: UUID(), exerciseName: "Lunges", sets: SetStruct.mockData)
    ]
}

extension SetStruct {
    static let mockData: [SetStruct] = [
        SetStruct(reps: 10, weight: 80.0),
        SetStruct(reps: 8, weight: 90.0),
        SetStruct(reps: 6, weight: 100.0)
    ]
}
#endif
