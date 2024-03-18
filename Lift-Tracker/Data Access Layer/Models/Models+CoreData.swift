//
//  Models+CoreData.swift
//  Lift-Tracker
//
//  Description:
//  This file provides extensions to CoreData Managed Object classes,
//  enabling conversions between CoreData Managed Objects and their
//  corresponding Swift structures. It enhances the integration of CoreData
//  with the app's data models.
//
//  Created by Dominic Danborn on 5/13/23.
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import CoreData

// Extend CoreData entities to conform to the ManagedEntity protocol
extension RoutineMO: ManagedEntity { }
extension ExerciseMO: ManagedEntity { }
extension WorkoutMO: ManagedEntity { }
extension WorkoutExerciseMO: ManagedEntity { }
extension WorkoutSetMO: ManagedEntity { }

extension Routine {
    // Initializes a RoutineStruct from a RoutineMO. Returns nil if essential properties are missing.
    init?(managedObject: RoutineMO) {
        guard let id = managedObject.id else { return nil }
        let name = managedObject.routineName
        let exercises = managedObject.exercises?.toArray(of: ExerciseMO.self).compactMap(Exercise.init)
        
        self.init(id: id,
                  routineName: name ?? "",
                  exercises: exercises ?? [Exercise]())
    }
    
    // Converts a RoutineStruct to RoutineMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> RoutineMO? {
        guard let routine = RoutineMO.insertNew(in: context)
        else { return nil }
        
        routine.routineName = routineName
        routine.id = id
        let storedExercises = exercises.compactMap { $0.store(in: context) }
        routine.exercises = NSSet(array: storedExercises)
        return routine
    }
}

extension Exercise {
    // Initializes an ExerciseStruct from a ExerciseMO. Returns nil if essential properties are missing.
    init?(managedObject: ExerciseMO) {
        guard let id = managedObject.id
        else { return nil }
        let exerciseName = managedObject.exerciseName
        let notes = managedObject.exerciseNotes
        let maxWeight = managedObject.maxWeight
        let maxVolume = managedObject.maxVolume
        let muscleGroup = MuscleGroup(rawValue: managedObject.muscleGroup)
        let exerciseType = ExerciseType(rawValue: managedObject.exerciseType)
        
        self.init(id: id,
                  exerciseName: exerciseName ?? "",
                  exerciseNotes: notes ?? "",
                  maxWeight: Int(maxWeight),
                  maxVolume: Int(maxVolume),
                  muscleGroup: muscleGroup,
                  exerciseType: exerciseType)
    }
    
    // Converts an ExerciseStruct to an ExerciseMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> ExerciseMO? {
        guard let exercise = ExerciseMO.insertNew(in: context)
        else { return nil }
        
        exercise.id = id
        exercise.exerciseName = exerciseName
        exercise.exerciseNotes = exerciseNotes
        exercise.maxWeight = Int64(maxWeight)
        exercise.maxVolume = Int64(maxVolume)
        exercise.muscleGroup = muscleGroup.rawValue
        exercise.exerciseType = exerciseType.rawValue
        return exercise
    }
}

extension Workout {
    // Initializes a Workout from a WorkoutMO. Returns nil if essential properties are missing.
    init?(managedObject: WorkoutMO) {
        guard let id = managedObject.id, let date = managedObject.date else { return nil }
        let exercisesMOs = managedObject.exercises?.toArray(of: WorkoutExerciseMO.self) ?? []
        let exercises = exercisesMOs.compactMap(WorkoutExercise.init)
        
        self.init(id: id,
                  date: date,
                  exercises: exercises)
    }

    // Converts a Workout to WorkoutMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> WorkoutMO? {
        guard let workout = WorkoutMO.insertNew(in: context)
        else { return nil }
        
        workout.id = id
        workout.date = date
        let storedExercises = exercises.compactMap { $0.store(in: context) }
        workout.exercises = NSSet(array: storedExercises)
        return workout
    }
}

extension WorkoutExercise {
    // Initializes a WorkoutExercise from a WorkoutExerciseMO.
    init?(managedObject: WorkoutExerciseMO) {
        guard let id = managedObject.id else { return nil }
        let setsMOs = managedObject.sets?.toArray(of: WorkoutSetMO.self) ?? []
        let sets = setsMOs.compactMap(WorkoutSet.init)

        self.init(id: id,
                  sets: sets)
    }

    // Converts a WorkoutExercise to WorkoutExerciseMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> WorkoutExerciseMO? {
        guard let workoutExercise = WorkoutExerciseMO.insertNew(in: context) else { return nil }

        workoutExercise.id = id
        let storedSets = sets.compactMap { $0.store(in: context) }
        workoutExercise.sets = NSSet(array: storedSets)
        return workoutExercise
    }
}

extension WorkoutSet {
    // Initializes a WorkoutSet from a WorkoutSetMO.
    init?(managedObject: WorkoutSetMO) {
        guard let id = managedObject.id else { return nil }
        let reps = Int(managedObject.reps)
        let weight = managedObject.weight
        let completed = managedObject.completed
        let setClassification = SetClassification(rawValue: managedObject.setClassification)

        self.init(id: id,
                  reps: reps,
                  weight: weight,
                  completed: completed,
                  setClassification: setClassification)
    }

    // Converts a WorkoutSet to WorkoutSetMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> WorkoutSetMO? {
        guard let workoutSet = WorkoutSetMO.insertNew(in: context) else { return nil }

        workoutSet.id = id
        workoutSet.reps = Int64(reps)
        workoutSet.weight = weight
        workoutSet.completed = completed
        workoutSet.setClassification = setClassification.rawValue
        return workoutSet
    }
}


// MARK: MO extensions

extension RoutineMO {
    func toStruct() -> Routine {
        return Routine(managedObject: self)!
    }
}

extension ExerciseMO {
    func toStruct() -> Exercise {
        return Exercise(managedObject: self)!
    }
    
    func update(with exercise: Exercise) {
        self.exerciseName = exercise.exerciseName
        self.id = exercise.id
    }
}

// MARK: Enum translations

extension MuscleGroup {
    var rawValue: Int16 {
        return Int16(self.rawValue)
    }

    init(rawValue: Int16) {
        self = MuscleGroup(rawValue: rawValue)
    }
}

extension ExerciseType {
    var rawValue: Int16 {
        return Int16(self.rawValue)
    }

    init(rawValue: Int16) {
        self = ExerciseType(rawValue: rawValue)
    }
}

extension SetClassification {
    var rawValue: Int16 {
        return Int16(self.rawValue)
    }

    init(rawValue: Int16) {
        self = SetClassification(rawValue: rawValue)
    }
}
