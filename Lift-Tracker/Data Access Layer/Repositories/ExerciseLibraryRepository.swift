//
//  ExerciseLibraryRepository.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/7/24.
//
//  Description:
//  This file defines the `RealExerciseLibraryRepository`.
//  The repository acts as an intermediary between the persistence layer (Core Data) and the application logic,
//  facilitating CRUD operations for exercises in the exerciseLibrary. It abstracts the underlying data fetching and manipulation
//  mechanisms, providing a clean interface for interacting with exercise data.
//  This includes creating, reading, updating, and deleting exercises, using Core Data and Combine for asynchronous operations.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import CoreData
import Combine

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
    /// This function fetches `ExerciseLibraryMO` and maps it to an array of exercises.
    ///
    /// - Returns:
    ///     - A publisher that emits an optional `ExerciseLibraryStruct` containing all exercises,
    ///   or an error if the fetch fails.
    func readExercises() -> AnyPublisher<[ExerciseStruct], Error> {
        // Create fetch request to get the ExerciseLibrary from the PersistentStore
        let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
        // Configure fetch request to avoid faults and prefetch relationships.
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]

        // Use the generic fetch method
        return persistentStore
            .fetch(fetchRequest) { libraryMO in
                // Check if the library has exercises, and if so, convert them to ExerciseStruct
                guard let exerciseMOs = libraryMO.exercises as? Set<ExerciseMO> else {
                    return [] // Return an empty array if no exercises are found
                }
                return exerciseMOs.compactMap(ExerciseStruct.init) // Convert to ExerciseStruct
            }
            .map { $0.first ?? [] } // Extract the first result (since there should only be one library) or return an empty array
            .eraseToAnyPublisher()
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
            let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
            
            // Ensure the exercise has a valid ID. If not, throw an error.
            guard let id = exercise.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            
            let fetchedLibrary = try context.fetch(fetchRequest)
            
            if let exerciseLibraryMO = fetchedLibrary.first {
                // Find the specific ExerciseMO to update
                if let existingExerciseMO = exerciseLibraryMO.exercises?.first(where: { ($0 as? ExerciseMO)?.id == id }) as? ExerciseMO {
                    // Update the properties of the ExerciseMO
                    existingExerciseMO.exerciseName = exercise.exerciseName
                    existingExerciseMO.exerciseNotes = exercise.exerciseNotes
                } else {
                    // If the exercise is not found, throw an error.
                    throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to find Exercise to update"])
                }
            }
            else {
                // If the exerciseLibrary is not found, throw an error.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find ExerciseLibrary to update an exercise"])
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
            let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            // Configure the fetch request to not return objects as faults and prefetch related exercises.
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
            
            // Ensure the exercise has an ID, otherwise throw an error.
            guard let exerciseId = exercise.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            
            let fetchedLibrary = try context.fetch(fetchRequest)
            
            if let exerciseLibraryMO = fetchedLibrary.first {
                // Check if the exercise library contains the specific exercise to be deleted.
                if let exercises = exerciseLibraryMO.exercises as? Set<ExerciseMO>,
                   let exerciseMOToDelete = exercises.first(where: { $0.id == exerciseId }) {
                    // Remove the exercise from the exercise library and delete it from the context.
                    exerciseLibraryMO.removeFromExercises(exerciseMOToDelete)
                    context.delete(exerciseMOToDelete)
                } else {
                    // If the exercise is not found, throw an error.
                    throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to find Exercise to update"])
                }
            }
            else {
                // If the exerciseLibrary is not found, throw an error.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find ExerciseLibrary to update an exercise"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
}
