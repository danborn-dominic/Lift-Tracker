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
struct RealExercisesRepository: ExercisesRepository {
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
    func createExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            // Map the ExerciseStruct to an ExerciseMO.
            guard let _ = exercise.store(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
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
    func readExercises() -> AnyPublisher<[Exercise], Error> {
        // Create fetch request to get the ExerciseLibrary from the PersistentStore
        let fetchRequest: NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()
        // Configure fetch request to avoid faults and prefetch relationships.
        fetchRequest.returnsObjectsAsFaults = false

        // Use the generic fetch method
        return persistentStore
            .fetch(fetchRequest, map: { Exercise(managedObject: $0) })
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
    func updateExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            let fetchRequest: NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()

            // Ensure the exercise has a valid ID. If not, throw an error.
            guard let id = exercise.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            
            let fetchedExercises = try context.fetch(fetchRequest)
            
            if let exerciseMO = fetchedExercises.first {
                exerciseMO.exerciseName = exercise.exerciseName
                exerciseMO.exerciseNotes = exercise.exerciseNotes
                exerciseMO.muscleGroup = exercise.muscleGroup.rawValue
                exerciseMO.exerciseType = exercise.muscleGroup.rawValue
                exerciseMO.maxWeight = Int64(exercise.maxWeight)
            } else {
                // If the routine is not found, throw an error.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find exercise to update"])
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
    func deleteExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        // Call the update function of the persistentStore.
        return persistentStore.update { context in
            // Create a fetch request for the ExerciseLibraryMO entity.
            let fetchRequest: NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()

            // Ensure the exercise has an ID, otherwise throw an error.
            guard let id = exercise.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            
            let fetchedExercises = try context.fetch(fetchRequest)
            
            if let exerciseMO = fetchedExercises.first {
                context.delete(exerciseMO)
            } else {
                // If the exercise is not found, throw an error.
                throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to find Exercise to delete"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
}
