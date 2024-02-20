//
//  ExerciseLibraryRepository.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/7/24.
//

import CoreData
import Combine

protocol ExerciseLibraryRepository {
    func createExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
    func readExercises() -> AnyPublisher<ExerciseLibraryStruct?, Error>
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
}

struct RealExerciseLibraryRepository: ExerciseLibraryRepository {
    let persistentStore: PersistentStore
    
    func createExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        print("DEBUG: Starting to create exercise in ExerciseLibraryRepository: \(exercise.exerciseName)")
        
        return persistentStore.update { context in
            print("DEBUG: Fetching ExerciseLibraryMO")
            let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            let libraries = try context.fetch(fetchRequest)
            
            let libraryMO: ExerciseLibraryMO
            if let existingLibrary = libraries.first {
                print("DEBUG: Found existing ExerciseLibraryMO")
                libraryMO = existingLibrary
            } else {
                print("DEBUG: Creating new ExerciseLibraryMO")
                libraryMO = ExerciseLibraryMO(context: context)
            }
            print("DEBUG: Mapping ExerciseStruct to ExerciseMO")
            guard let exerciseMO = exercise.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
            print("DEBUG: Adding ExerciseMO to ExerciseLibraryMO")
            libraryMO.addToExercises(exerciseMO)
        }
        .map { _ in
            print("DEBUG: Successfully created exercise")
        }
        .eraseToAnyPublisher()
    }
    
    
    func readExercises() -> AnyPublisher<ExerciseLibraryStruct?, Error> {
        print("DEBUG: Reading exercises in ExerciseLibraryRepository")
        let fetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        print("DEBUG: Making fetch request")
        return persistentStore.fetchOne(fetchRequest, map: { ExerciseLibraryStruct(managedObject: $0) })
    }
    
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        return persistentStore.update { context in
            guard let _ = exercise.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        print("DEBUG: Initiating deletion of exercise in ExerciseLibraryRepository: \(exercise.exerciseName)")
        
        return persistentStore.update { context in
            let libraryFetchRequest: NSFetchRequest<ExerciseLibraryMO> = ExerciseLibraryMO.fetchRequest()
            libraryFetchRequest.returnsObjectsAsFaults = false
            libraryFetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
            
            guard let exerciseId = exercise.id else {
                print("ERROR: Exercise id is missing")
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Exercise id is missing"])
            }
            
            print("DEBUG: Id of exercise: ", exerciseId)
            
            do {
                let fetchedLibraries = try context.fetch(libraryFetchRequest)
                guard let exerciseLibraryMO = fetchedLibraries.first else {
                    print("ERROR: Failed to find ExerciseLibraryMO")
                    throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find ExerciseLibraryMO"])
                }
                print("DEBUG: Successfully fetched ExerciseLibraryMO", exerciseLibraryMO)
                
                // Find and delete the specific exercise
                if let exercises = exerciseLibraryMO.exercises as? Set<ExerciseMO> {
                    print("DEBUG: Exercise IDs in library:")
                    exercises.forEach { print($0.id?.uuidString ?? "nil") }

                    if let exerciseMOToDelete = exercises.first(where: { $0.id == exerciseId }) {
                        print("DEBUG: Removing \(exerciseMOToDelete) from libraryMO")
                        exerciseLibraryMO.removeFromExercises(exerciseMOToDelete)
                        context.delete(exerciseMOToDelete)
                    } else {
                        print("ERROR: Exercise ID \(exerciseId) not found in library")
                    }
                } else {
                    print("ERROR: No exercises found in library")
                }
                print("DEBUG: Exercise was removed from library and deleted")
            } catch {
                print("ERROR: \(error.localizedDescription)")
                throw error
            }
        }
        .map { _ in
            print("DEBUG: Exercise deletion process completed")
        }
        .eraseToAnyPublisher()
    }
}
