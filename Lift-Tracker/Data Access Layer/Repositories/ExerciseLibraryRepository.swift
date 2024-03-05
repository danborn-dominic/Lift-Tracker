//
//  ExerciseLibraryRepository.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/7/24.
//
//  Description:
//  This file defines the `ExerciseLibraryRepository` protocol and its concrete implementation `RealExerciseLibraryRepository`.
//  The repository acts as an intermediary between the persistence layer (Core Data) and the application logic,
//  facilitating CRUD operations for exercises in the exerciseLibrary. It abstracts the underlying data fetching and manipulation
//  mechanisms, providing a clean interface for interacting with exercise data.
//  This includes creating, reading, updating, and deleting exercises, using Core Data and Combine for asynchronous operations.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import CoreData
import Combine

// Protocol for the implementation of a repository managing the ExerciseLibrary. Follows CRUD architecture.
protocol ExerciseLibraryRepository {
    /// Creates a new exercise and saves it to the persistence layer.
    func createExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
    
    /// Reads all exercises from the persistence layer.
    func readExercises() -> AnyPublisher<ExerciseLibraryStruct?, Error>
    
    /// Updates a specific exercise in the persistence layer.
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
    
    /// Deletes a specific exercise from the persistence layer.
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
}

// Concrete implementation using the PersistentStore.
struct RealExerciseLibraryRepository: ExerciseLibraryRepository {
    let persistentStore: PersistentStore
    
    /// Creates a new exercise and adds it to the exercise library in the persistent store.
    /// This function takes an `ExerciseStruct`, maps it to a managed object (ExerciseMO),
    /// and adds it to the existing `ExerciseLibraryMO` or creates a new library if none exists.
    ///
    /// - Parameters:
    ///     - exercise: The `ExerciseStruct` instance to be created.
    /// - Returns:
    ///     - A publisher that completes when the exercise has been successfully added,
    ///   or with an error if the process fails.
    func createExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            // Fetch the existing ExerciseLibraryMO or create a new one if it doesn't exist.
            let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            let libraries = try context.fetch(fetchRequest)
            
            let libraryMO: ExerciseLibraryMO
            if let existingLibrary = libraries.first {
                // Use the existing library.
                libraryMO = existingLibrary
            } else {
                // Create a new library if none exists.
                libraryMO = ExerciseLibraryMO(context: context)
            }
            
            // Map the ExerciseStruct to an ExerciseMO.
            guard let exerciseMO = exercise.store(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
            
            // Add the new exercise to the library.
            libraryMO.addToExercises(exerciseMO)
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    /// Reads all exercises from the exercise library in the persistent store.
    /// This function fetches `ExerciseLibraryMO` and maps it to `ExerciseLibraryStruct`.
    ///
    /// - Returns:
    ///     - A publisher that emits an optional `ExerciseLibraryStruct` containing all exercises,
    ///   or an error if the fetch fails.
    func readExercises() -> AnyPublisher<ExerciseLibraryStruct?, Error> {
        // Create fetch request to get exercises from the PersistentStore
        let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
        // Configure fetch request to avoid faults and prefetch relationships.
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        
        // Fetch the exercise library and map it to a struct.
        return persistentStore.fetchOne(fetchRequest, map: { ExerciseLibraryStruct(managedObject: $0) })
    }
    
    /// Updates an existing exercise in the persistent store.
    /// This function takes an updated `ExerciseStruct`, maps it to a managed object (ExerciseMO),
    /// and saves the changes to the persistent store.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance with updated information.
    /// - Returns:
    ///     - A publisher that completes when the exercise has been successfully updated,
    ///   or with an error if the update fails.
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            // Map the updated ExerciseStruct to an existing ExerciseMO.
            guard let _ = exercise.store(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    /// Deletes a specific exercise from the exercise library in the persistent store.
    /// This function fetches `ExerciseLibraryMO`, finds the specific `ExerciseMO` to delete,
    /// and removes it from the library and context.
    ///
    /// - Parameters:
    ///    - exercise: The `ExerciseStruct` instance to be deleted.
    /// - Returns:
    ///     - A publisher that completes when the exercise has been successfully deleted,
    ///   or with an error if the deletion fails.
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            // Create a fetch request for the ExerciseLibraryMO entity.
            let libraryFetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            // Configure the fetch request to not return objects as faults and prefetch related exercises.
            libraryFetchRequest.returnsObjectsAsFaults = false
            libraryFetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
            
            // Ensure the exercise has an ID, otherwise throw an error.
            guard let exerciseId = exercise.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            
            do {
                // Fetch the ExerciseLibraryMO entities.
                let fetchedLibraries = try context.fetch(libraryFetchRequest)
                // Ensure there is at least one ExerciseLibraryMO entity, otherwise throw an error.
                guard let exerciseLibraryMO = fetchedLibraries.first else {
                    throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find ExerciseLibraryMO"])
                }
                
                // Check if the exercise library contains the specific exercise to be deleted.
                if let exercises = exerciseLibraryMO.exercises as? Set<ExerciseMO>,
                   let exerciseMOToDelete = exercises.first(where: { $0.id == exerciseId }) {
                    // Remove the exercise from the exercise library and delete it from the context.
                    exerciseLibraryMO.removeFromExercises(exerciseMOToDelete)
                    context.delete(exerciseMOToDelete)
                }
            } catch {
                // Propagate any errors encountered during the fetch or delete operations.
                throw error
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
}
