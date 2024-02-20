//
//  Models+CoreData.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/13/23.
//

import Foundation
import CoreData

extension WorkoutMO: ManagedEntity { }
extension ExerciseMO: ManagedEntity { }
extension SetMO: ManagedEntity { }
extension ExerciseLibraryMO: ManagedEntity { }

extension WorkoutStruct {
    
    init?(managedObject: WorkoutMO) {
        print("INFO mapping from workoutMO to workoutStruct")
        guard let name = managedObject.workoutName,
              let id = managedObject.id,
              let exercises = managedObject.exercises?.toArray(of: ExerciseMO.self).compactMap(ExerciseStruct.init)
        else { return nil }
        
        self.init(workoutName: name, id: id, exercises: exercises)
    }
    
    @discardableResult
    func mapToMO(in context: NSManagedObjectContext) -> WorkoutMO? {
        print("INFO mapping workoutStruct to WorkoutMO")
        
        guard let workout = WorkoutMO.insertNew(in: context)
        else { return nil }
        
        workout.workoutName = workoutName
        if let id = id {
            workout.id = id
        } else {
            workout.id = UUID()
        }
        
        let storedExercises = exercises.compactMap { $0.mapToMO(in: context) }
        workout.exercises = NSSet(array: storedExercises)
        
        return workout
    }
    
}

extension ExerciseStruct {
    
    init?(managedObject: ExerciseMO) {
        print("DEBUG: Starting mapping from ExerciseMO to ExerciseStruct.")

        // Print out the basic information of the ExerciseMO
        print("DEBUG: ExerciseMO - ID: \(String(describing: managedObject.id)), Name: \(String(describing: managedObject.exerciseName)).")

        // Ensure that the essential properties, like ID and name, are present
        guard let exerciseName = managedObject.exerciseName, let id = managedObject.id else {
            print("ERROR: Essential properties (id or name) are missing in ExerciseMO.")
            return nil
        }

        // Handle optional notes property
        let notes = managedObject.exerciseNotes
        print("DEBUG: Notes associated with the exercise: \(String(describing: notes)).")

        // Process the sets relationship if it exists
        let sets: [SetStruct]
        if let setsMO = managedObject.sets?.toArray(of: SetMO.self) {
            print("DEBUG: Processing \(setsMO.count) sets associated with the exercise.")
            sets = setsMO.compactMap { setMO in
                print("DEBUG: Processing SetMO with ID: \(String(describing: setMO.id)).")
                return SetStruct(managedObject: setMO)
            }
        } else {
            print("DEBUG: No sets associated with this exercise.")
            sets = []
        }

        // Initialize the ExerciseStruct with optional notes
        self.init(id: id, exerciseName: exerciseName, exerciseNotes: notes ?? "", sets: sets)
        print("DEBUG: Successfully mapped ExerciseMO to ExerciseStruct.")
    }


    
    @discardableResult
    func mapToMO(in context: NSManagedObjectContext) -> ExerciseMO? {
        print("DEBUG: mapping exerciseStruct to ExerciseMO")
        guard let exercise = ExerciseMO.insertNew(in: context)
        else { return nil }
        
        exercise.exerciseName = exerciseName
        if let id = id {
            exercise.id = id
        } else {
            exercise.id = UUID()
        }
        
        let storedSets = sets.compactMap { $0.mapToMO(in: context) }
        exercise.sets = NSSet(array: storedSets)
        
        return exercise
    }
    
}

extension SetStruct {
    
    init?(managedObject: SetMO) {
        print("INFO mapping setMO to setStruct")
        self.init(reps: Int(managedObject.numReps), weight: managedObject.weight)
    }
    
    @discardableResult
    func mapToMO(in context: NSManagedObjectContext) -> SetMO? {
        print("INFO mapping setStruct to SetMO")
        guard let set = SetMO.insertNew(in: context)
        else { return nil }
        
        set.numReps = Int64(repetitions)
        set.weight = weight
        
        return set
    }
}

extension ExerciseLibraryStruct {
    
    init?(managedObject: ExerciseLibraryMO) {
        print("DEBUG: Starting mapping from ExerciseLibraryMO to ExerciseLibraryStruct.")
        
        if let exercisesSet = managedObject.exercises as? Set<ExerciseMO> {
            print("DEBUG: Successfully casted exercises to Set<ExerciseMO> with \(exercisesSet.count) exercises.")
            let exercisesArray = Array(exercisesSet)
            print("DEBUG: Converted exercises set to array. Processing each ExerciseMO.")
            let exercisesStructs = exercisesArray.compactMap { exerciseMO in
                print("DEBUG: Processing ExerciseMO with ID: \(String(describing: exerciseMO.id)) and name: \(String(describing: exerciseMO.exerciseName)).")
                return ExerciseStruct(managedObject: exerciseMO)
            }
            
            // Initialize the ExerciseLibraryStruct with the array of ExerciseStructs
            self.init(exercises: exercisesStructs)
            print("DEBUG: Completed mapping to ExerciseLibraryStruct with \(exercisesStructs.count) exercises.")
        } else {
            // If casting fails, print an error and return nil
            print("ERROR: Failed to cast 'exercises' relationship to Set<ExerciseMO>.")
            return nil
        }
    }
    
    
    
    @discardableResult
    func mapToMO(in context: NSManagedObjectContext) -> ExerciseLibraryMO? {
        print("INFO mapping exerciseLibraryStruct to ExerciseLibraryMO")
        
        guard let exerciseLibrary = ExerciseLibraryMO.insertNew(in: context)
        else { return nil }
        
        if let id = id {
            exerciseLibrary.id = id
        } else {
            exerciseLibrary.id = UUID()
        }
        
        let exercisesArray = exercises.compactMap { $0.mapToMO(in: context) }
        exerciseLibrary.exercises = NSSet(array: exercisesArray)
        
        return exerciseLibrary
    }
}
