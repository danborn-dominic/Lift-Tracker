//
//  ExerciseInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/8/24.
//

import Foundation

protocol ExerciseInteractor {
    func loadExercises()
    func addExercise(exercise: ExerciseStruct)
    func deleteExercise(exercise: ExerciseStruct)
}

class RealExerciseInteractor: ExerciseInteractor {
    let exercisesRepository: ExerciseLibraryRepository
    var appState: DataStore<AppState>
    private var cancelBag = CancelBag()
    
    init(exercisesRepository: ExerciseLibraryRepository, appState: DataStore<AppState>) {
        print("DEBUG: initializing ExerciseInteractor")
        self.exercisesRepository = exercisesRepository
        self.appState = appState
    }
    
    func loadExercises() {
        print("DEBUG: Loading exercises from ExerciseInteractor")
        let cancelBag = CancelBag()
        print("DEBUG: Setting exercises state to loading")
        appState.value.userData.exercises.setIsLoading(cancelBag: cancelBag)
        exercisesRepository.readExercises()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("DEBUG: Successfully finished loading exercises")
                case .failure(let error):
                    print("DEBUG: Failed to load exercises: \(error)")
                }
            }, receiveValue: { [weak self] optionalExerciseLibrary in
                print("DEBUG: Exercises data received in interactor")
                if let exerciseLibrary = optionalExerciseLibrary {
                    print("DEBUG: Loaded exercises", exerciseLibrary.exercises)
                    self?.appState.value.userData.exercises = .loaded(exerciseLibrary)
                } else {
                    print("WARNING: No exercises data available, setting state to loaded with empty array")
                    let emptyExerciseLibrary = ExerciseLibraryStruct(id: UUID(), exercises: [])
                    self?.appState.value.userData.exercises = .loaded(emptyExerciseLibrary)
                }
            })
            .store(in: cancelBag)
    }
    
    func addExercise(exercise: ExerciseStruct) {
        print("DEBUG: Adding exercise from Exercise Interactor: ", exercise.exerciseName)
        let cancelBag = CancelBag()
        print("DEBUG: Setting exercises state to loading")
        appState.value.userData.exercises.setIsLoading(cancelBag: cancelBag)
        exercisesRepository.createExercise(exercise: exercise)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                print("DEBUG: Received completion in adding exercise")
                switch completion {
                case .finished:
                    print("DEBUG: Successfully finished adding exercise")
                    self?.appState.value.userData.exercises = .isLoading(last: self?.appState.value.userData.exercises.value, cancelBag: cancelBag)
                    print("DEBUG: Reloading exercises")
                    self?.loadExercises()
                case .failure(let error):
                    print("ERROR: Failed to add exercise: \(error)")
                    self?.appState.value.userData.exercises = .failed(error)
                }
            }, receiveValue: { _ in
                print("DEBUG: Exercise added successfully")
            })
            .store(in: cancelBag)
    }
    
    func deleteExercise(exercise: ExerciseStruct) {
        print("DEBUG: Initiating deletion of exercise: \(exercise.exerciseName)")
        let cancelBag = CancelBag()
        appState.value.userData.exercises.setIsLoading(cancelBag: cancelBag)
        print("DEBUG: Set exercises state to loading for deletion process")
        exercisesRepository.deleteExercise(exercise: exercise)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                print("DEBUG: Received completion for delete exercise request")
                switch completion {
                case .finished:
                    print("DEBUG: Delete exercise request completed")
                    self?.appState.value.userData.exercises = .isLoading(last: self?.appState.value.userData.exercises.value, cancelBag: cancelBag)
                    self?.loadExercises()
                case .failure(let error):
                    print("DEBUG: Delete exercise request failed with error: \(error)")
                    self?.appState.value.userData.exercises = .failed(error)
                }
            }, receiveValue: { _ in
                print("DEBUG: Delete exercise request succeeded")
            })
            .store(in: cancelBag)
    }
    
}

struct StubExerciseInteractor: ExerciseInteractor {
    func loadExercises() {
    }
    
    func addExercise(exercise: ExerciseStruct) {
    }
    
    func deleteExercise(exercise: ExerciseStruct) {
    }
}
