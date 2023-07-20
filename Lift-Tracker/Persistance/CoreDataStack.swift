import Foundation
import CoreData
import Combine

protocol PersistentStore {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result

    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
    func printWorkouts()
}

struct CoreDataStack: PersistentStore {

    private let persistentContainer: NSPersistentContainer
    private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)
    private let bgQueue = DispatchQueue(label: "coredata")

    init() {
        persistentContainer = NSPersistentContainer(name: "Lift_Tracker")
        bgQueue.async { [weak isStoreLoaded, weak persistentContainer] in
            persistentContainer?.loadPersistentStores { (storeDescription, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        isStoreLoaded?.send(completion: .failure(error))
                    } else {
                        persistentContainer?.viewContext.configureAsReadOnlyContext()
                        isStoreLoaded?.value = true
                    }
                }
            }
        }
    }

    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error> {
        return Future { promise in
            do {
                let fetchedObjects = try self.persistentContainer.viewContext.fetch(fetchRequest)
                let mappedObjects = try fetchedObjects.compactMap(map)
                promise(.success(mappedObjects))
            } catch {
                promise(.failure(error))
            }
        }
            .eraseToAnyPublisher()
    }

    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
        return Future { promise in
            do {
                let result = try operation(self.persistentContainer.viewContext)
                try self.persistentContainer.viewContext.save()
                promise(.success(result))
            } catch {
                self.persistentContainer.viewContext.rollback()
                promise(.failure(error))
            }
        }
            .eraseToAnyPublisher()
    }

    func printWorkouts() {
        print("INFO printing coredata contents")
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WorkoutMO> = WorkoutMO.fetchRequest()

        do {
            let workouts = try context.fetch(fetchRequest)
            for workout in workouts {
                print("Workout: \(workout.name ?? ""), ID: \(workout.id?.uuidString ?? "")")
                if let exercises = workout.exercises?.allObjects as? [ExerciseMO] {
                    for exercise in exercises {
                        print("\tExercise: \(exercise.name ?? "")")
                        if let sets = exercise.sets?.allObjects as? [SetMO] {
                            for set in sets {
                                print("\t\tSet: Reps - \(set.numReps), Weight - \(set.weight)")
                            }
                        }
                    }
                }
            }
        } catch {
            print("INFO Error fetching workouts: \(error)")
        }
    }

}
