//
//  Models.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/13/23.
//
//  Description:
//  This file contains the data model definitions used throughout the Lift-Tracker app,
//  including structures for routines, exercises, sets, and other related entities.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation

// RoutineStruct represents a routine created by the user in the Lift-Tracker app.
// It includes a unique identifier, a name, and a collection of exercises.
struct Routine: Codable, Equatable, Identifiable, Hashable {
    let id: UUID?                       // Unique identifier for the routine. Must be assigned on creation.
    var routineName: String             // Name of the routine.
    var exercises: [Exercise]           // Collection of exercises.
    
    // Initializes a new routine with an ID and a name.
    init(id: UUID, routineName: String) {
        self.id = id
        self.routineName = routineName
        self.exercises = [Exercise]()
    }
    
    // Initializes a new routine with an ID, name, and set of exercises.
    init(id: UUID, routineName: String, exercises: [Exercise]) {
        self.id = id
        self.routineName = routineName
        self.exercises = exercises
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equality is based on the `id` of the routine
    static func ==(lhs: Routine, rhs: Routine) -> Bool {
        lhs.id == rhs.id
    }
}

// Exercise represents an exercise created by the user in the Lift-Tracker app.
// It includes a unique identifier, a name, and notes about the exercise.
struct Exercise: Codable, Equatable, Identifiable, Hashable {
    let id: UUID?                       // Unique identifier for the exercise. Must be assigned on creation.
    var exerciseName: String            // Name of the exercise.
    var exerciseNotes: String           // Notes about the exercise.
    var muscleGroup: MuscleGroup
    var exerciseType: ExerciseType
    var maxWeight: Int
    var repsForMaxWeight: Int
    var isPerformed: Bool
    var dateLastPerformed: Date
    
    init(id: UUID,
         exerciseName: String = "",
         exerciseNotes: String = "",
         maxWeight: Int = 0,
         repsForMaxWeight: Int = 0,
         muscleGroup: MuscleGroup = .other,
         exerciseType: ExerciseType = .other,
         isPerformed: Bool = false,
         dateLastPerformed: Date = Date()
    ) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = exerciseNotes
        self.maxWeight = maxWeight
        self.repsForMaxWeight = repsForMaxWeight
        self.muscleGroup = muscleGroup
        self.exerciseType = exerciseType
        self.isPerformed = isPerformed
        self.dateLastPerformed = dateLastPerformed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
}

// A workout is a performed routine
struct Workout {
    let id: UUID?
    let date: Date
    var exercises: [WorkoutExercise]
    
    init(id: UUID,
         date: Date = Date(),
         exercises: [WorkoutExercise] = [WorkoutExercise]()) {
        self.id = id
        self.date = date
        self.exercises = exercises
    }
}

struct WorkoutExercise {
    let id: UUID?
    var sets: [WorkoutSet]
}

struct WorkoutSet {
    let id: UUID?
    var reps: Int
    var weight: Double
    var completed: Bool
    var setClassification: SetClassification
    
    init(id: UUID,
         reps: Int = 0,
         weight: Double = 0,
         completed: Bool = false,
         setClassification: SetClassification = .working) {
        self.id = id
        self.reps = reps
        self.weight = weight
        self.completed = completed
        self.setClassification = setClassification
    }
}

// MARK: Enums

enum MuscleGroup: Int16, Codable, CaseIterable {
    case undefined = 0
    case chest = 1
    case back = 2
    case triceps = 3
    case biceps = 4
    case forearms = 5
    case shoulders = 6
    case quads = 7
    case hamstrings = 8
    case glutes = 9
    case calves = 10
    case core = 11
    case fullBody = 12
    case other = 13
    
    static let defaultValue = MuscleGroup.undefined
    
    var displayName: String {
        switch self {
        case .undefined: return "Undefined"
        case .chest: return "Chest"
        case .back: return "Back"
        case .triceps: return "Triceps"
        case .biceps: return "Biceps"
        case .forearms: return "Forearms"
        case .shoulders: return "Shoulders"
        case .quads: return "Quads"
        case .hamstrings: return "Hamstrings"
        case .glutes: return "Glutes"
        case .calves: return "Calves"
        case .core: return "Core"
        case .fullBody: return "Full Body"
        case .other: return "Other"
        }
    }
}

enum ExerciseType: Int16, Codable, CaseIterable {
    case undefined = 0
    case dumbbell = 1
    case barbell = 2
    case machine = 3
    case cable = 4
    case freeweight = 5
    case bodyWeight = 6
    case cardio = 7
    case other = 8
    
    static let defaultValue = ExerciseType.undefined
    
    var displayName: String {
        switch self {
        case .undefined: return "Undefined"
        case .dumbbell: return "Dumbbell"
        case .barbell: return "Barbell"
        case .machine: return "Machine"
        case .cable: return "Cable"
        case .freeweight: return "Freeweight"
        case .bodyWeight: return "Bodyweight"
        case .cardio: return "Cardio"
        case .other: return "Other"
        }
    }
}

enum SetClassification: Int16, Codable {
    case undefined = 0
    case warmup = 1
    case working = 2
    case failure = 3
    
    static let defaultValue = SetClassification.undefined
}
