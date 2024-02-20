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
extension RoutineStruct {
    static let mockData: [RoutineStruct] = [
        RoutineStruct(id: UUID(), routineName: "Full Body Workout", exercises: ExerciseStruct.mockData),
        RoutineStruct(id: UUID(), routineName: "Upper Body Workout", exercises: [ExerciseStruct.mockData[0], ExerciseStruct.mockData[1]]),
        RoutineStruct(id: UUID(), routineName: "Lower Body Workout", exercises: [ExerciseStruct.mockData[2]]),
        RoutineStruct(id: UUID(), routineName: "Push Workout", exercises: [ExerciseStruct.mockData[3]]),
        RoutineStruct(id: UUID(), routineName: "Pull Workout", exercises: [ExerciseStruct.mockData[4]]),
        RoutineStruct(id: UUID(), routineName: "Legs Workout", exercises: [ExerciseStruct.mockData[5]])
    ]
}

extension ExerciseStruct {
    static let mockData: [ExerciseStruct] = [
        ExerciseStruct(id: UUID(), exerciseName: "Bench Press"),
        ExerciseStruct(id: UUID(), exerciseName: "Pull Ups"),
        ExerciseStruct(id: UUID(), exerciseName: "Squats"),
        ExerciseStruct(id: UUID(), exerciseName: "Shoulder Press"),
        ExerciseStruct(id: UUID(), exerciseName: "Bent Over Rows"),
        ExerciseStruct(id: UUID(), exerciseName: "Lunges")
    ]
}
#endif
