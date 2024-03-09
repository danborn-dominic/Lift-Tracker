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
extension ExerciseLibraryMO: ManagedEntity { }

extension Routine {
    // Initializes a RoutineStruct from a RoutineMO. Returns nil if essential properties are missing.
    init?(managedObject: RoutineMO) {
        guard let id = managedObject.id,
              let name = managedObject.routineName,
              let exercises = managedObject.exercises?.toArray(of: ExerciseMO.self).compactMap(Exercise.init)
        else { return nil }
        
        self.init(id: id, routineName: name, exercises: exercises)
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

extension RoutineMO {
    func toStruct() -> Routine {
        return Routine(managedObject: self)!
    }
}

extension Exercise {
    // Initializes an ExerciseStruct from a ExerciseMO. Returns nil if essential properties are missing.
    init?(managedObject: ExerciseMO) {
        guard let exerciseName = managedObject.exerciseName,
              let id = managedObject.id
        else { return nil }
        let notes = managedObject.exerciseNotes
        
        self.init(id: id, exerciseName: exerciseName, exerciseNotes: notes ?? "")
    }
    
    // Converts an ExerciseStruct to an ExerciseMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> ExerciseMO? {
        guard let exercise = ExerciseMO.insertNew(in: context)
        else { return nil }
        
        exercise.exerciseName = exerciseName
        exercise.id = id
        return exercise
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

extension ExerciseLibraryStruct {
    // Initializes an ExerciseLibraryStruct from a ExerciseLibraryMO. Returns nil if essential properties are missing.
    init?(managedObject: ExerciseLibraryMO) {
        guard let id = managedObject.id else { return nil }
        if let exercisesSet = managedObject.exercises as? Set<ExerciseMO> {
            let exercisesArray = Array(exercisesSet)
            let exercisesStructs = exercisesArray.compactMap { exerciseMO in
                return Exercise(managedObject: exerciseMO)
            }
            self.init(id: id, exercises: exercisesStructs)
        } else { return nil }
    }
    
    // Converts an ExerciseLibraryStruct to an ExerciseLibraryMO and returns it.
    @discardableResult
    func store(in context: NSManagedObjectContext) -> ExerciseLibraryMO? {
        guard let exerciseLibrary = ExerciseLibraryMO.insertNew(in: context)
        else { return nil }
        
        exerciseLibrary.id = id
        let exercisesArray = exercises.compactMap { $0.store(in: context) }
        exerciseLibrary.exercises = NSSet(array: exercisesArray)
        return exerciseLibrary
    }
}

extension ExerciseLibraryMO {
    func toStruct() -> ExerciseLibraryStruct {
        return ExerciseLibraryStruct(managedObject: self)!
    }
}
