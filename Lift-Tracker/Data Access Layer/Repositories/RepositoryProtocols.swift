//
//  RepositoryProtocols.swift
//  Lift-Tracker
//
// Description:
//  This file consolidates protocols defining the repository layer for the Lift-Tracker app.
//  It includes RoutinesRepository and ExerciseLibraryRepository, each following CRUD principles
//  for managing routines and exercises respectively. These protocols abstract the data layer's
//  operations, ensuring a decoupled and scalable app architecture. They leverage Combine for
//  reactive and asynchronous data handling.
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//


import CoreData
import Combine

// Protocol for the implementation of a repository managing routines. Follows CRUD architecture.
protocol RoutinesRepository {
    /// Creates a new routine and saves it to the persistence layer.
    func createRoutine(routine: Routine) -> AnyPublisher<Void, Error>
    
    /// Reads all routines from the persistence layer.
    func readRoutines() -> AnyPublisher<[Routine], Error>
    
    /// Updates a specific routine in the persistence layer.
    func updateRoutine(routine: Routine) -> AnyPublisher<Void, Error>
    
    /// Deletes a specific routine from the persistence layer.
    func deleteRoutine(routine: Routine) -> AnyPublisher<Void, Error>
}

// Protocol for the implementation of a repository managing the ExerciseLibrary. Follows CRUD architecture.
protocol ExercisesRepository {
    /// Creates a new exercise and saves it to the persistence layer.
    func createExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
    
    /// Reads all exercises from the persistence layer.
    func readExercises() -> AnyPublisher<[Exercise], Error>
    
    /// Updates a specific exercise in the persistence layer.
    func updateExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
    
    /// Deletes a specific exercise from the persistence layer.
    func deleteExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
}
