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

extension WorkoutStruct {

    init?(managedObject: WorkoutMO) {
        print("INFO mapping from workoutMO to workoutStruct")
        print("INFO MO exercises ", managedObject.exercises)
        guard let name = managedObject.name,
            let id = managedObject.id,
            let exercises = managedObject.exercises?.toArray(of: ExerciseMO.self).compactMap(ExerciseStruct.init)
            else { return nil }

        print("INFO exercises ", exercises)
        self.init(name: name, id: id, exercises: exercises)
    }

    func mapToMO(in context: NSManagedObjectContext) -> WorkoutMO? {
        print("INFO mapping workoutStruct to WorkoutMO")

        guard let workout = WorkoutMO.insertNew(in: context)
            else { return nil }

        workout.name = name
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
        print("INFO mapping from exerciseMO to exersiseStruct")
        guard
            let name = managedObject.name,
            let id = managedObject.id,
            let sets = managedObject.sets?.toArray(of: SetMO.self).compactMap(SetStruct.init)
            else { return nil }

        self.init(name: name, sets: sets)
    }

    @discardableResult
    func mapToMO(in context: NSManagedObjectContext) -> ExerciseMO? {
        print("INFO mapping exerciseStruct to ExerciseMO")
        guard let exercise = ExerciseMO.insertNew(in: context)
            else { return nil }

        exercise.name = name
        exercise.id = UUID() // Ensure that an id is always set

        let storedSets = sets.compactMap { $0.mapToMO(in: context) }
        exercise.sets = NSSet(array: storedSets)

        return exercise
    }

}

extension SetStruct {

    init?(managedObject: SetMO) {
        print("INFO mapping setMO to setStruct")
        guard let id = managedObject.id else { return nil }

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

