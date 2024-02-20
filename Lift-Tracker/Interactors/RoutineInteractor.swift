//
//  WorkoutInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import Combine
import Foundation
import SwiftUI

protocol RoutineInteractor {
    func loadRoutines()
    func addRoutine(routine: RoutineStruct)
    func deleteRoutine(routine: RoutineStruct)
}

class RealRoutineInteractor: RoutineInteractor {
    let workoutsRepository: RoutinesRepository
    var appState: DataStore<AppState>
    private var cancelBag = CancelBag()
    
    init(workoutsRepository: RoutinesRepository, appState: DataStore<AppState>) {
        print("INFO initializing WorkoutInteractor")
        self.workoutsRepository = workoutsRepository
        self.appState = appState
    }
    
    func loadRoutines() {
        print("INFO loading workouts")
        
        let cancelBag = CancelBag()
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        
        workoutsRepository.readRoutines()
            .receive(on: DispatchQueue.main)
            .sinkToLoadable { loadable in
                self.appState.value.userData.routines = loadable
            }
            .store(in: cancelBag)
    }
    
    func addRoutine(routine: RoutineStruct) {
        print("INFO: Starting to add workout: \(routine)")
        let cancelBag = CancelBag()
        print("INFO: Created a new CancelBag for the operation")
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        print("INFO: Workout loadable state set to isLoading")
        workoutsRepository.createRoutine(routine: routine)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("INFO: Workout creation operation completed successfully")
                    self?.appState.value.userData.routines = .isLoading(last: self?.appState.value.userData.routines.value, cancelBag: cancelBag)
                    self?.loadRoutines()
                case .failure(let error):
                    print("ERROR: Workout creation failed with error: \(error)")
                    self?.appState.value.userData.routines = .failed(error)
                }
            }, receiveValue: { _ in
                print("INFO: Received a value from createWorkout publisher, but no action needed")
            })
            .store(in: cancelBag)
    }
    
    
    func deleteRoutine(routine: RoutineStruct) {
        print("INFO deleting workout " + routine.routineName)
        let cancelBag = CancelBag()
        appState.value.userData.routines.setIsLoading(cancelBag: cancelBag)
        
        workoutsRepository.deleteRoutine(routine: routine)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.appState.value.userData.routines = .isLoading(last: self?.appState.value.userData.routines.value, cancelBag: cancelBag)
                    self?.loadRoutines()
                case .failure(let error):
                    self?.appState.value.userData.routines = .failed(error)
                }
            }, receiveValue: { _ in })
            .store(in: cancelBag)
    }
}

struct StubRoutineInteractor: RoutineInteractor {
    func loadRoutines() {
    }
    
    func addRoutine(routine: RoutineStruct) {
    }
    
    func deleteRoutine(routine: RoutineStruct) {
    }
}
