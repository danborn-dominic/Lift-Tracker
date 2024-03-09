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

extension Routine {
    static let testData: [Routine] = [
        Routine(id: UUID(), routineName: "Push", exercises: [Exercise]()),
        Routine(id: UUID(), routineName: "Pull", exercises: [Exercise]()),
        Routine(id: UUID(), routineName: "Legs", exercises: [Exercise]())
    ]
}

extension Exercise {
    static let testData: [Exercise] = [
        Exercise(id: UUID(), exerciseName: "Bench Press"),
        Exercise(id: UUID(), exerciseName: "Pull Ups"),
        Exercise(id: UUID(), exerciseName: "Squats"),
        Exercise(id: UUID(), exerciseName: "Shoulder Press"),
        Exercise(id: UUID(), exerciseName: "Bent Over Rows"),
        Exercise(id: UUID(), exerciseName: "Lunges")
    ]
}
