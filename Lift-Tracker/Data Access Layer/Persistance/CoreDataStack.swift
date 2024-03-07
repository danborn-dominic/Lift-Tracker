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
    /// This initializer is responsible for setting up the Core Data stack with a specified version of the data model.
    /// It initializes the NSPersistentContainer and configures it with the correct store based on the provided directory, domain mask, and version number.
    /// The loading of the persistent stores is performed asynchronously to avoid blocking the main thread.
    ///
    /// - Parameters:
    ///   - directory: The FileManager.SearchPathDirectory where the database should be stored. Defaults to .documentDirectory.
    ///   - domainMask: The FileManager.SearchPathDomainMask for the directory. Defaults to .userDomainMask.
    ///   - vNumber: The version number of the data model.
    init(directory: FileManager.SearchPathDirectory = .documentDirectory,
         domainMask: FileManager.SearchPathDomainMask = .userDomainMask,
         version vNumber: UInt) {
        
        // Create a `Version` instance with the provided version number.
        let version = Version(vNumber)
        
        // Initialize the NSPersistentContainer with the model name.
        // The model name is derived from the `Version` instance.
        persistentContainer = NSPersistentContainer(name: version.modelName)
        
        // Check if a URL for the database file can be constructed using the specified directory and domain mask.
        if let url = version.dbFileURL(directory, domainMask) {
            // Create a description for the persistent store using the URL.
            let store = NSPersistentStoreDescription(url: url)
            // Assign this store description to the persistent container.
            persistentContainer.persistentStoreDescriptions = [store]
        }
        
        // Perform the loading of the persistent stores on a background queue.
        bgQueue.async { [weak isStoreLoaded, weak persistentContainer] in
            // Load the persistent stores, which involves setting up the database file and performing any necessary migrations.
            persistentContainer?.loadPersistentStores { (storeDescription, error) in
                // Once the store loading is complete, handle the result on the main thread.
                DispatchQueue.main.async {
                    if let error = error {
                        // If there was an error loading the stores, send a failure completion to `isStoreLoaded`.
                        isStoreLoaded?.send(completion: .failure(error))
                    } else {
                        // If the stores were loaded successfully, configure the main context for read-only operations.
                        persistentContainer?.viewContext.configureAsReadOnlyContext()
                        // Update `isStoreLoaded` to indicate successful loading of the store.
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
        assert(Thread.isMainThread)

        let fetch = Future <[V], Error> { promise in
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
        return onStoreIsReady
            .flatMap { fetch }
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
        let update = Future <Result, Error> { [weak bgQueue, weak persistentContainer] promise in
            bgQueue?.async {
                guard let context = persistentContainer?.newBackgroundContext() else { return }
                context.configureAsUpdateContext()
                context.performAndWait {
                    do {
                        let result = try operation(context)
                        if context.hasChanges {
                            try context.save()
                        }
                        context.reset()
                        promise(.success(result))
                    } catch {
                        context.reset()
                        promise(.failure(error))
                    }
                }
            }
        }
        return onStoreIsReady
            .flatMap { update }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var onStoreIsReady: AnyPublisher<Void, Error> {
        return isStoreLoaded
            .filter { $0 }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

// MARK: - Versioning

// Extension to `CoreDataStack` to define a nested `Version` struct.
extension CoreDataStack {
    // A struct to encapsulate information about a specific version of the database.
    struct Version {
        // Private property to hold the version number.
        private let number: UInt
        
        // Initializer to create a `Version` instance with a specific version number.
        init(_ number: UInt) {
            self.number = number
        }
        
        // Computed property to return the model name.
        var modelName: String {
            return "Lift_Tracker"
        }
        
        // Function to generate the file URL for the database.
        // It takes a directory and domainMask to determine where to store the database file.
        func dbFileURL(_ directory: FileManager.SearchPathDirectory,
                       _ domainMask: FileManager.SearchPathDomainMask) -> URL? {
            // Uses FileManager to find the URL for the specified directory and domain,
            // then appends the subpath for the database file.
            return FileManager.default
                .urls(for: directory, in: domainMask).first?
                .appendingPathComponent(subpathToDB)
        }
        
        // Private computed property to define the subpath for the database file.
        // The database file is named "db.sql".
        private var subpathToDB: String {
            return "db.sql"
        }
    }
}

// Extension to `CoreDataStack.Version` to provide the current actual version number.
extension CoreDataStack.Version {
    // A static property to represent the current version of the database.
    static var actual: UInt { 1 }
}
