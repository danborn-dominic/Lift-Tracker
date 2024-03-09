//
//  RoutineRepository.swift
//  Lift-Tracker
//
//
//  Description:
//  This file defines the `RealRoutinesRepository`.
//  The repository acts as an intermediary between the persistence layer (Core Data) and the application logic,
//  facilitating CRUD operations for routines. It abstracts the underlying data fetching and manipulation
//  mechanisms, providing a clean interface for interacting with routine data.
//  This includes creating, reading, updating, and deleting routines, using Core Data and Combine for asynchronous operations.
//
//  Created by Dominic Danborn on 5/12/23.
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import CoreData
import Combine

// Concrete implementation using the PersistentStore.
struct RealRoutinesRepository: RoutinesRepository {
    let persistentStore: PersistentStore
    
    /// Creates a new routine and saves it to the persistent store.
    /// This function maps the given `RoutineStruct` to a managed object and then performs
    /// a CoreData update operation to save it.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to create.
    /// - Returns:
    ///     -  A publisher that completes when the routine has been successfully created,
    ///   or with an error if the creation fails.
    func createRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        // Call persistentStore's update function.
        return persistentStore.update { context in
            // Attempt to map the RoutineStruct to a RoutineMO (Managed Object).
            // If mapping fails, throw an error.
            guard let _ = routine.store(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    /// Reads all routines from the persistent store.
    /// This function fetches `RoutineMO` objects from CoreData and maps them to `RoutineStruct` objects.
    ///
    /// - Returns:
    ///     - A publisher emitting an array of `RoutineStruct` when the operation succeeds,
    ///   or an error if the fetch operation fails.
    func readRoutines() -> AnyPublisher<[Routine], Error> {
        // Build the fetch request to the persistentStore
        let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        
        // Fetch the routines from the persistent store and map each RoutineMO to a RoutineStruct.
        return persistentStore
            .fetch(fetchRequest, map: { Routine(managedObject: $0) })
            .eraseToAnyPublisher()
    }
    
    /// Updates an existing routine in the persistent store.
    /// This function takes a `RoutineStruct`, maps it to a managed object (RoutineMO),
    /// and updates it in the CoreData context.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to update.
    /// - Returns:
    ///     - A publisher that completes when the routine has been successfully updated,
    ///   or with an error if the update fails.
    func updateRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        // Call persistentStore's update function.
        return persistentStore.update { context in
            let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
            // Ensure the routine has a valid ID. If not, throw an error.
            
            guard let id = routine.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Routine id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            // Executes the fetch request to retrieve the RoutineMO.
            let fetchedRoutines = try context.fetch(fetchRequest)
            
            // Check if the fetched result contains the routine to update.
            if let routineMO = fetchedRoutines.first {
                routineMO.routineName = routine.routineName
                
                // Convert the exercises from the RoutineMO to a set for comparison
                let currentExerciseMOs = routineMO.exercises as? Set<ExerciseMO> ?? []
                // Convert the exercises from the RoutineStruct to a set for comparison.
                let newExercisesSet = Set(routine.exercises)
                
                // Determine exercises that are no longer present and should be deleted.
                let exercisesToDelete = currentExerciseMOs.filter { !newExercisesSet.contains($0.toStruct()) }
                exercisesToDelete.forEach { context.delete($0) }
                
                // Map new exercises to ExerciseMOs, updating existing ones or adding new ones.
                let updatedExerciseMOs = try newExercisesSet.map { exerciseStruct -> ExerciseMO in
                    
                    // Check if the exercise already exists and update it.
                    if let existingExerciseMO = currentExerciseMOs.first(where: { $0.id == exerciseStruct.id }) {
                        existingExerciseMO.update(with: exerciseStruct)
                        return existingExerciseMO
                    } else {
                        // Create a new ExerciseMO for new exercises.
                        guard let newExerciseMO = exerciseStruct.store(in: context) else {
                            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to map ExerciseStruct to ExerciseMO"])
                        }
                        return newExerciseMO
                    }
                }
                
                // Update the RoutineMO's exercises with the modified set.
                routineMO.exercises = NSSet(array: updatedExerciseMOs)                
            } else {
                // If the routine is not found, throw an error.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find routine to update"])
            }
        }
        // Converts the result of the database operation to a Void return type.
        .map { _ in }
        // Erases the type of publisher to simplify downstream usage.
        .eraseToAnyPublisher()
    }
    
    /// Deletes an existing routine from the persistent store.
    /// This function fetches a specific `RoutineMO` using the routine's ID, and then deletes it
    /// from the CoreData context.
    ///
    /// - Parameters:
    ///    - routine: The `RoutineStruct` instance to delete.
    /// - Returns:
    ///     - A publisher that completes when the routine has been successfully deleted,
    ///   or with an error if the deletion fails.
    func deleteRoutine(routine: Routine) -> AnyPublisher<Void, Error> {
        // Call persistentStore's update function.
        return persistentStore.update { context in
            let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
            
            // Ensure the routine has a valid ID. If not, throw an error.
            guard let id = routine.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Routine id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            
            // Fetch the routine from the context using the ID.
            let routines = try context.fetch(fetchRequest)
            if let routineMO = routines.first {
                // If the routine is found, delete it.
                context.delete(routineMO)
            } else {
                // If the routine is not found, throw an error.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find routine to delete"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
}
