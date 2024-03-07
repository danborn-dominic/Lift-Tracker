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
    func loadExercises(exercises: LoadableSubject<[ExerciseStruct]>)
    
    // Function to add a new exercise.
    func addExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
    
    // Function to delete an existing exercise.
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error>
}

// Protocol defining the core functionalities for handling routines.
protocol RoutineInteractor {
    // Function to load all routines.
    func loadRoutines(routines: LoadableSubject<[RoutineStruct]>)
    
    // Function to add a new routine.
    func addRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
    
    // Function to delete an existing routine.
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error>
}
