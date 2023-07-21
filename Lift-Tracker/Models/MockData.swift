//
//  MockData.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import Foundation

#if DEBUG

    extension WorkoutStruct {
        static let mockedData: [WorkoutStruct] = [
            WorkoutStruct(name: "Full Body Workout", id: UUID(), exercises: ExerciseStruct.mockedData),
            WorkoutStruct(name: "Upper Body Workout", id: UUID(), exercises: [ExerciseStruct.mockedData[0], ExerciseStruct.mockedData[1]]),
            WorkoutStruct(name: "Lower Body Workout", id: UUID(), exercises: [ExerciseStruct.mockedData[2]]),
            WorkoutStruct(name: "Push Workout", id: UUID(), exercises: [ExerciseStruct.mockedData[3]]),
            WorkoutStruct(name: "Pull Workout", id: UUID(), exercises: [ExerciseStruct.mockedData[4]]),
            WorkoutStruct(name: "Legs Workout", id: UUID(), exercises: [ExerciseStruct.mockedData[5]])
        ]
    }

    extension ExerciseStruct {
        static let mockedData: [ExerciseStruct] = [
            ExerciseStruct(name: "Bench Press", sets: SetStruct.mockedData),
            ExerciseStruct(name: "Pull Ups", sets: SetStruct.mockedData),
            ExerciseStruct(name: "Squats", sets: SetStruct.mockedData),
            ExerciseStruct(name: "Shoulder Press", sets: SetStruct.mockedData),
            ExerciseStruct(name: "Bent Over Rows", sets: SetStruct.mockedData),
            ExerciseStruct(name: "Lunges", sets: SetStruct.mockedData)
        ]
    }

    extension SetStruct {
        static let mockedData: [SetStruct] = [
            SetStruct(reps: 10, weight: 80.0),
            SetStruct(reps: 8, weight: 90.0),
            SetStruct(reps: 6, weight: 100.0)
        ]
    }

#endif
