import Foundation
import CoreData
import Combine

protocol PersistentStore {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
    
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error>
    func fetchOne<T, V>(_ fetchRequest: NSFetchRequest<T>,
                        map: @escaping (T) throws -> V?) -> AnyPublisher<V?, Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
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
    
    func fetchOne<T, V>(_ fetchRequest: NSFetchRequest<T>,
                        map: @escaping (T) throws -> V?) -> AnyPublisher<V?, Error> {
        return Future<V?, Error> { promise in
            do {
                print("DEBUG: Fetching objects from context")
                let fetchedObjects = try self.persistentContainer.viewContext.fetch(fetchRequest)
                print("DEBUG: Number of objects fetched: \(fetchedObjects.count)")

                if let firstObject = fetchedObjects.first {
                    print("DEBUG: First object fetched: \(firstObject)")
                    let mappedObject = try map(firstObject)
                    print("DEBUG: Mapped object: \(String(describing: mappedObject))")
                    promise(.success(mappedObject))
                } else {
                    print("DEBUG: No objects fetched")
                    promise(.success(nil))
                }
            } catch {
                print("ERROR: Fetch operation failed with error: \(error)")
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
}
