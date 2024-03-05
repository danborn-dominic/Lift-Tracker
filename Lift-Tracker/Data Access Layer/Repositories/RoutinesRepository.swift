//
//  RoutineRepository.swift
//  Lift-Tracker
//
//
//  Description:
//  This file defines the `RoutinesRepository` protocol and its concrete implementation `RealRoutinesRepository`.
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

// Protocol for the implementation of a repository managing routines. Follows CRUD architecture.
protocol RoutinesRepository {
    /// Creates a new routine and saves it to the persistence layer.
    func createRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
    
    /// Reads all routines from the persistence layer.
    func readRoutines() -> AnyPublisher<[RoutineStruct], Error>
    
    /// Updates a specific routine in the persistence layer.
    func updateRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
    
    /// Deletes a specific routine from the persistence layer.
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
}

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
    func createRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        // Call persistentStore's update function.
        return persistentStore.update { context in
            // Attempt to map the RoutineStruct to a RoutineMO (Managed Object).
            // If mapping fails, throw an error.
            guard let _ = routine.mapToMO(in: context) else {
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
    func readRoutines() -> AnyPublisher<[RoutineStruct], Error> {
        // Build the fetch request to the persistentStore
        let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        
        // Fetch the routines from the persistent store and map each RoutineMO to a RoutineStruct.
        return persistentStore
            .fetch(fetchRequest, map: { RoutineStruct(managedObject: $0) })
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
    func updateRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        // Call persistentStore's update function.
        return persistentStore.update { context in
            // Attempt to map the RoutineStruct to a RoutineMO (Managed Object).
            // If mapping fails, throw an error.
            guard let _ = routine.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
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
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
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
