//
//  WorkoutRepository.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import CoreData
import Combine

// Updated protocol to include Combine
protocol WorkoutsRepository {
    func createWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error>
    func readWorkouts() -> AnyPublisher<[WorkoutStruct], Error>
    func updateWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error>
    func deleteWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error>
}

struct RealWorkoutsRepository: WorkoutsRepository {
    let persistentStore: PersistentStore

    func createWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error> {
        print("INFO creating workout: ", workout)
        return persistentStore.update { context in
            guard let _ = workout.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
            .map { _ in }
            .eraseToAnyPublisher()
    }

    func readWorkouts() -> AnyPublisher<[WorkoutStruct], Error> {
        persistentStore.printWorkouts()
        print("INFO reading workouts in repository")
        let fetchRequest: NSFetchRequest<WorkoutMO> = WorkoutMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        return persistentStore.fetch(fetchRequest, map: { WorkoutStruct(managedObject: $0) })
    }


    func updateWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error> {
        return persistentStore.update { context in
            guard let _ = workout.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
            .map { _ in }
            .eraseToAnyPublisher()
    }

    func deleteWorkout(workout: WorkoutStruct) -> AnyPublisher<Void, Error> {
        print("INFO deleting workout in repository", workout.name)
        return persistentStore.update { context in
            let fetchRequest: NSFetchRequest<WorkoutMO> = WorkoutMO.fetchRequest()

            // Safely unwrap workout.id
            guard let id = workout.id else {
                // Handle error condition where id is nil.
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Workout id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)

            let workouts = try context.fetch(fetchRequest)
            if let workoutMO = workouts.first {
                context.delete(workoutMO)
            } else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find workout to delete"])
            }
        }
            .map { _ in }
            .eraseToAnyPublisher()
    }

}

