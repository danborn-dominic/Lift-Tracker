//
//  Models.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/13/23.
//

import Foundation

struct WorkoutStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var workoutName: String
    var exercises: [ExerciseStruct]
    
    init(workoutName: String) {
        self.id = UUID()
        self.workoutName = workoutName
        self.exercises = [ExerciseStruct]()
    }
    
    init(workoutName: String, id: ID) {
        self.id = id
        self.workoutName = workoutName
        self.exercises = [ExerciseStruct]()
    }
    
    init(workoutName: String, id: ID, exercises: [ExerciseStruct]) {
        self.id = id
        self.workoutName = workoutName
        self.exercises = exercises
    }
    
    init(workoutName: String, exercises: [ExerciseStruct]) {
        self.id = nil
        self.workoutName = workoutName
        self.exercises = exercises
    }
}

struct ExerciseStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var exerciseName: String
    var exerciseNotes: String
    var sets: [SetStruct]
    
    init(exerciseName: String) {
        self.id = UUID()
        self.exerciseName = exerciseName
        self.exerciseNotes = ""
        self.sets = [SetStruct]()
    }
    
    init(id: UUID, exerciseName: String) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = ""
        self.sets = [SetStruct]()
    }
    
    init(id: UUID, exerciseName: String, sets: [SetStruct]) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = ""
        self.sets = sets
    }
    
    init(id: UUID, exerciseName: String, exerciseNotes: String) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = exerciseNotes
        self.sets = [SetStruct]()
    }
    
    init(id: UUID, exerciseName: String, exerciseNotes: String, sets: [SetStruct]) {
        self.id = id
        self.exerciseName = exerciseName
        self.exerciseNotes = exerciseNotes
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

struct ExerciseLibraryStruct: Codable, Equatable, Identifiable {
    let id: UUID?
    var exercises: [ExerciseStruct]
    
    init() {
        self.id = UUID()
        self.exercises = [ExerciseStruct]()
    }
    
    init(exercises: [ExerciseStruct]) {
        self.id = UUID()
        self.exercises = exercises
    }
}
