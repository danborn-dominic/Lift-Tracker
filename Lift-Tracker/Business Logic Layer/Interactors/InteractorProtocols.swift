//
//  InteractorProtocols.swift
//  Lift-Tracker
//
// Description:
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import Combine

// Protocol defining the core functionalities for handling routines.
protocol ExerciseInteractor {
    // Function to load all exercises.
    func loadExercises(exercises: LoadableSubject<[Exercise]>)
    
    // Function to add a new exercise.
    func addExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
    
    // Function to update an existing exercise.
    func updateExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
    
    // Function to delete an existing exercise.
    func deleteExercise(exercise: Exercise) -> AnyPublisher<Void, Error>
}

// Protocol defining the core functionalities for handling routines.
protocol RoutineInteractor {
    // Function to load all routines.
    func loadRoutines(routines: LoadableSubject<[Routine]>)
    
    // Function to add a new routine.
    func addRoutine(routine: Routine) -> AnyPublisher<Void, Error>
    
    // Function to update an existing routine.
    func updateRoutine(routine: Routine) -> AnyPublisher<Void, Error>
    
    // Function to delete an existing routine.
    func deleteRoutine(routine: Routine) -> AnyPublisher<Void, Error>
}
