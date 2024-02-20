//
//  WorkoutRepository.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import CoreData
import Combine

protocol WorkoutsRepository {
    func createWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error>
    func readWorkouts() -> AnyPublisher<[RoutineStruct], Error>
    func updateWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error>
    func deleteWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error>
}

struct RealWorkoutsRepository: WorkoutsRepository {
    let persistentStore: PersistentStore
    
    func createWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error> {
        print("INFO creating workout: ", workout)
        return persistentStore.update { context in
            guard let _ = workout.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    func readWorkouts() -> AnyPublisher<[RoutineStruct], Error> {
        print("INFO reading workouts in repository")
        let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["exercises"]
        return persistentStore.fetch(fetchRequest, map: { RoutineStruct(managedObject: $0) })
    }
    
    
    func updateWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error> {
        return persistentStore.update { context in
            guard let _ = workout.mapToMO(in: context) else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mapping to Managed Object failed"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
    func deleteWorkout(workout: RoutineStruct) -> AnyPublisher<Void, Error> {
        print("DEBUG: Initiating deletion of workout in WorkoutRepository: \(workout.routineName)")
        
        return persistentStore.update { context in
            let fetchRequest: NSFetchRequest<RoutineMO> = RoutineMO.fetchRequest()
            guard let id = workout.id else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Workout id is missing"])
            }
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            
            let workouts = try context.fetch(fetchRequest)
            if let routineMO = workouts.first {
                context.delete(routineMO)
            } else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find workout to delete"])
            }
        }
        .map { _ in }
        .eraseToAnyPublisher()
    }
    
}

