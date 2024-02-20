//
//  CoreDataStack.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/29/23.
//
//  Description:
//  This file defines the CoreDataStack struct, which serves as the central point
//  of interaction with the Core Data framework within the Lift-Tracker app. It provides
//  an abstraction layer for Core Data operations, facilitating data fetching and saving
//  processes. The CoreDataStack manages the NSPersistentContainer, ensuring that the
//  data model is correctly set up and ready for use. It also implements the PersistentStore
//  protocol, providing generic methods for fetching and updating data in a type-safe manner.
//  Additionally, the file includes extensions for handling asynchronous data operations
//  using Combine, providing a modern and efficient approach to managing Core Data tasks.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import CoreData
import Combine

// PersistentStore protocol.
// This protocol defines the core functionalities for interacting with a persistent store,
// such as a Core Data database. It provides a set of methods for fetching and updating data
// in a type-safe and generic way. The protocol uses Combine to handle asynchronous operations.
protocol PersistentStore {
    // Typealias for a database operation that can throw an error and return a result.
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
    
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error>
    func fetchOne<T, V>(_ fetchRequest: NSFetchRequest<T>,
                        map: @escaping (T) throws -> V?) -> AnyPublisher<V?, Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
}

// CoreDataStack
// The actual coredata stack, which implements the persistentStore protocol.
struct CoreDataStack: PersistentStore {
    
    // NSPersistentContainer manages the Core Data stack (model, context, and persistent store coordinator).
    private let persistentContainer: NSPersistentContainer
    
    // A subject to track the loading state of the persistent store.
    private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)
    
    // A background queue for performing asynchronous operations related to Core Data.
    private let bgQueue = DispatchQueue(label: "coredata")
    
    /// Initializes a new instance of CoreDataStack.
    /// - Sets up the persistent container with the specified name and loads its stores.
    init() {
        persistentContainer = NSPersistentContainer(name: "Lift_Tracker")
        
        // Perform the store loading asynchronously to avoid blocking the main thread.
        bgQueue.async { [weak isStoreLoaded, weak persistentContainer] in
            // Load persistent stores (database files) associated with the model.
            persistentContainer?.loadPersistentStores { (storeDescription, error) in
                // Once loading is complete, switch back to the main thread.
                DispatchQueue.main.async {
                    if let error = error {
                        // Notify subscribers about the failure in loading the store.
                        isStoreLoaded?.send(completion: .failure(error))
                    } else {
                        // Configure the view context as read-only if the store is loaded successfully.
                        persistentContainer?.viewContext.configureAsReadOnlyContext()
                        // Notify subscribers that the store has been successfully loaded.
                        isStoreLoaded?.value = true
                    }
                }
            }
        }
    }
    
    /// Fetches objects from the Core Data store and maps them to a different type.
    /// This generic method fetches objects of type `T` and converts them to type `V`.
    ///
    /// - Parameters:
    ///   - fetchRequest: An `NSFetchRequest` instance configured to fetch `T` objects.
    ///   - map: A closure that maps each fetched `T` object to a `V` object.
    ///
    /// - Returns: A publisher that emits an array of `V` objects or an error.
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error> {
        return Future { promise in
            do {
                // Execute the fetch request on the managed object context.
                let fetchedObjects = try self.persistentContainer.viewContext.fetch(fetchRequest)
                // Use the provided mapping function to convert each fetched object.
                let mappedObjects = try fetchedObjects.compactMap(map)
                // If successful, promise a success with the array of mapped objects.
                promise(.success(mappedObjects))
            } catch {
                // If an error occurs, promise a failure with the error.
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
