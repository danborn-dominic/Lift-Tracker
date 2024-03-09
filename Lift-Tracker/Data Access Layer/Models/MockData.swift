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
    static let testData: [RoutineStruct] = [
        RoutineStruct(id: UUID(), routineName: "Full Body", exercises: ExerciseStruct.testData),
        RoutineStruct(id: UUID(), routineName: "Upper Body", exercises: [ExerciseStruct.testData[0], ExerciseStruct.testData[1]]),
        RoutineStruct(id: UUID(), routineName: "Lower Body", exercises: [ExerciseStruct.testData[2]]),
        RoutineStruct(id: UUID(), routineName: "Push", exercises: [ExerciseStruct.testData[3]]),
        RoutineStruct(id: UUID(), routineName: "Pull", exercises: [ExerciseStruct.testData[4]]),
        RoutineStruct(id: UUID(), routineName: "Legs", exercises: [ExerciseStruct.testData[5]])
    ]
}

extension ExerciseStruct {
    static let testData: [ExerciseStruct] = [
        ExerciseStruct(id: UUID(), exerciseName: "Bench Press"),
        ExerciseStruct(id: UUID(), exerciseName: "Pull Ups"),
        ExerciseStruct(id: UUID(), exerciseName: "Squats"),
        ExerciseStruct(id: UUID(), exerciseName: "Shoulder Press"),
        ExerciseStruct(id: UUID(), exerciseName: "Bent Over Rows"),
        ExerciseStruct(id: UUID(), exerciseName: "Lunges")
    ]
}
#endif
