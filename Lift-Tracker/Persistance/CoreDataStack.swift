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
    
    /// Fetches a single object from the Core Data store and maps it to a different type.
    /// This generic method fetches the first object of type `T` from the results and converts it to type `V`.
    ///
    /// - Parameters:
    ///   - fetchRequest: An `NSFetchRequest` instance configured to fetch `T` objects.
    ///   - map: A closure that maps the fetched `T` object to a `V` object.
    ///
    /// - Returns: A publisher that emits an optional `V` object or an error.
    func fetchOne<T, V>(_ fetchRequest: NSFetchRequest<T>,
                        map: @escaping (T) throws -> V?) -> AnyPublisher<V?, Error> {
        return Future<V?, Error> { promise in
            do {
                // Execute the fetch request on the managed object context.
                let fetchedObjects = try self.persistentContainer.viewContext.fetch(fetchRequest)
                // Check if at least one object is fetched and process it.
                if let firstObject = fetchedObjects.first {
                    // Map the first fetched object to the desired type.
                    let mappedObject = try map(firstObject)
                    // Promise success with the mapped object.
                    promise(.success(mappedObject))
                } else {
                    // If no objects are fetched, return nil.
                    promise(.success(nil))
                }
            } catch {
                // If an error occurs during the fetch operation, promise a failure with the error.
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Executes a database operation in the context and persists any changes.
    /// This method takes a closure of type `DBOperation` which performs a task in the managed object context.
    /// If the operation is successful, changes are saved to the persistent store.
    ///
    /// - Parameter operation: A closure that performs the database operation and returns a `Result`.
    ///
    /// - Returns: A publisher that emits the result of the operation or an error.
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
        return Future { promise in
            do {
                // Perform the operation within the managed object context.
                let result = try operation(self.persistentContainer.viewContext)
                // Attempt to save any changes made during the operation.
                try self.persistentContainer.viewContext.save()
                // If successful, promise the result.
                promise(.success(result))
            } catch {
                // In case of an error, rollback any changes made during the operation.
                self.persistentContainer.viewContext.rollback()
                // Promise a failure with the encountered error.
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
