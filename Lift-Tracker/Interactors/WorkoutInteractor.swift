//
//  WorkoutInteractor.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import Combine
import Foundation
import SwiftUI

// this is the interface
protocol WorkoutInteractor {

    func loadWorkouts()
    func addWorkout(workout: WorkoutStruct)
    func deleteWorkout(workout: WorkoutStruct)

}

// this is the concrete class
class RealWorkoutInteractor: WorkoutInteractor {

    // has access to the repository for managing the database
    let workoutsRepository: WorkoutsRepository
    // has access to the app state to update data
    var appState: WorkoutStore<AppState>

    private var cancelBag = CancelBag()


    // constructor
    init(workoutsRepository: WorkoutsRepository, appState: WorkoutStore<AppState>) {
        print("INFO initializing interactor")
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

    func addWorkout(workout: WorkoutStruct) {
        print("INFO adding workout: ", workout)
        let cancelBag = CancelBag()
        appState.value.userData.workouts.setIsLoading(cancelBag: cancelBag)

        workoutsRepository.createWorkout(workout: workout)
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

    func deleteWorkout(workout: WorkoutStruct) {
        print("INFO deleting workout " + workout.name)
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

    func addWorkout(workout: WorkoutStruct) {
    }

    func deleteWorkout(workout: WorkoutStruct) {
    }

}
