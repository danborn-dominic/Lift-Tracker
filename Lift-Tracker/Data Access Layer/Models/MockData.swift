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
        Exercise(id: UUID(), exerciseName: "Bench Press"),
        Exercise(id: UUID(), exerciseName: "Pull Ups"),
        Exercise(id: UUID(), exerciseName: "Squats"),
        Exercise(id: UUID(), exerciseName: "Shoulder Press"),
        Exercise(id: UUID(), exerciseName: "Bent Over Rows"),
        Exercise(id: UUID(), exerciseName: "Lunges")
    ]
}
#endif
