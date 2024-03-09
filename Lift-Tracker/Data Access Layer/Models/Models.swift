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
    var exercises: [Exercise]     // Collection of exercises.
    
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

// ExerciseStruct represents an exercise created by the user in the Lift-Tracker app.
// It includes a unique identifier, a name, and notes about the exercise.
struct Exercise: Codable, Equatable, Identifiable, Hashable {
    let id: UUID?                       // Unique identifier for the exercise. Must be assigned on creation.
    var exerciseName: String            // Name of the exercise.
    var exerciseNotes: String           // Notes about the exercise.
    
    // Initializes a new exercise with an ID and a name.
    init(id: UUID, exerciseName: String) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = ""
    }
    
    // Initializes a new exercise with an ID, a name, and notes.
    init(id: UUID, exerciseName: String, exerciseNotes: String) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = exerciseNotes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equality is based on the `id` of the exercise
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
}

// ExerciseLibraryStruct represents a collection of the exercises created by the user in the Lift-Tracker app.
// It includes a unique identifier and a collection of ALL exercises that exist in the app.
struct ExerciseLibrary: Codable, Equatable, Identifiable {
    let id: UUID?                       // Unique identifier for the exercise. Must be assigned on creation.
    var exercises: [Exercise]     // A collection of all the exercises in the app.
    
    // Initializes a new ExerciseLibrary with an ID.
    init(id: UUID) {
        self.id = id
        self.exercises = [Exercise]()
    }
    
    // Initializes a new ExerciseLibrary with an ID and a collection of exercises.
    init(id: UUID, exercises: [Exercise]) {
        self.id = id
        self.exercises = exercises
    }
}
