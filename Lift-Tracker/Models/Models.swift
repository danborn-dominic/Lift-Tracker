//
//  Models.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/13/23.
//

import Foundation

struct WorkoutStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var name: String
    var exercises: [ExerciseStruct]

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.exercises = [ExerciseStruct]()
    }

    init(name: String, id: ID) {
        self.id = id
        self.name = name
        self.exercises = [ExerciseStruct]()
    }

    init(name: String, id: ID, exercises: [ExerciseStruct]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }

    init(name: String, exercises: [ExerciseStruct]) {
        self.id = nil
        self.name = name
        self.exercises = exercises
    }
}

struct ExerciseStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var name: String
    var sets: [SetStruct]

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.sets = [SetStruct]()
    }

    init(name: String, sets: [SetStruct]) {
        self.id = UUID()
        self.name = name
        self.sets = sets
    }
}

struct SetStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var repetitions: Int
    var weight: Double

    init() {
        self.id = UUID()
        self.repetitions = 0
        self.weight = 0.0
    }

    init(reps: Int, weight: Double) {
        self.id = UUID()
        self.repetitions = reps
        self.weight = weight
    }
}

extension WorkoutStruct {
    static var mockData: [WorkoutStruct] {
        [
            WorkoutStruct(name: "Upper Body", id: UUID(), exercises: ExerciseStruct.mockData),
            WorkoutStruct(name: "Lower Body", id: UUID(), exercises: ExerciseStruct.mockData)
        ]
    }
}

extension ExerciseStruct {
    static var mockData: [ExerciseStruct] {
        [
            ExerciseStruct(name: "Push Ups", sets: SetStruct.mockData),
            ExerciseStruct(name: "Pull Ups", sets: SetStruct.mockData)
        ]
    }
}

extension SetStruct {
    static var mockData: [SetStruct] {
        [
            SetStruct(reps: 10, weight: 20),
            SetStruct(reps: 8, weight: 25)
        ]
    }
}
