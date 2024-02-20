//
//  WorkoutInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import Combine
import Foundation
import SwiftUI

protocol WorkoutInteractor {
    func loadWorkouts()
    func addWorkout(workout: RoutineStruct)
    func deleteWorkout(workout: RoutineStruct)
}

class RealWorkoutInteractor: WorkoutInteractor {
    let workoutsRepository: WorkoutsRepository
    var appState: WorkoutStore<AppState>
    private var cancelBag = CancelBag()
    
    init(workoutsRepository: WorkoutsRepository, appState: WorkoutStore<AppState>) {
        print("INFO initializing WorkoutInteractor")
        self.workoutsRepository = workoutsRepository
        self.appState = appState
    }
    
    func loadWorkouts() {
        print("INFO loading workouts")
        
        let cancelBag = CancelBag()
        appState.value.userData.workouts.setIsLoading(cancelBag: cancelBag)
        
        workoutsRepository.readWorkouts()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadable in
                self.appState.value.userData.workouts = loadable
            }
            .store(in: cancelBag)
    }
    
    func addWorkout(workout: RoutineStruct) {
        print("INFO: Starting to add workout: \(workout)")
        let cancelBag = CancelBag()
        print("INFO: Created a new CancelBag for the operation")
        appState.value.userData.workouts.setIsLoading(cancelBag: cancelBag)
        print("INFO: Workout loadable state set to isLoading")
        workoutsRepository.createWorkout(workout: workout)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("INFO: Workout creation operation completed successfully")
                    self?.appState.value.userData.workouts = .isLoading(last: self?.appState.value.userData.workouts.value, cancelBag: cancelBag)
                    self?.loadWorkouts()
                case .failure(let error):
                    print("ERROR: Workout creation failed with error: \(error)")
                    self?.appState.value.userData.workouts = .failed(error)
                }
            }, receiveValue: { _ in
                print("INFO: Received a value from createWorkout publisher, but no action needed")
            })
            .store(in: cancelBag)
    }
    
    
    func deleteWorkout(workout: RoutineStruct) {
        print("INFO deleting workout " + workout.routineName)
        let cancelBag = CancelBag()
        appState.value.userData.workouts.setIsLoading(cancelBag: cancelBag)
        
        workoutsRepository.deleteWorkout(workout: workout)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.appState.value.userData.workouts = .isLoading(last: self?.appState.value.userData.workouts.value, cancelBag: cancelBag)
                    self?.loadWorkouts()
                case .failure(let error):
                    self?.appState.value.userData.workouts = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)
    }
}

struct StubWorkoutInteractor: WorkoutInteractor {
    func loadWorkouts() {
    }
    
    func addWorkout(workout: RoutineStruct) {
    }
    
    func deleteWorkout(workout: RoutineStruct) {
    }
}
