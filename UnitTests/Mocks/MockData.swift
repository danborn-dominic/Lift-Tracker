//
//  MockData.swift
//  UnitTests
//
//  Description:
//  This file contains mock data to be used in tests.
//
//  Created by Dominic Danborn on 3/1/24.
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
@testable import Lift_Tracker

extension RoutineStruct {
    static let testData: [RoutineStruct] = [
        RoutineStruct(id: UUID(), routineName: "Push", exercises: [ExerciseStruct.testData[0], ExerciseStruct.testData[3]]),
        RoutineStruct(id: UUID(), routineName: "Pull", exercises: [ExerciseStruct.testData[1], ExerciseStruct.testData[4]]),
        RoutineStruct(id: UUID(), routineName: "Legs", exercises: [ExerciseStruct.testData[2], ExerciseStruct.testData[5]])
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
