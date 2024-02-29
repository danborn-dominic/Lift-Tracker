//
//  MockedPersistentStore.swift
//  UnitTests
//
//  Description:
//  This file contains the MockedPersistentStore class, a crucial component for unit testing in the Lift-Tracker app.
//  The class implements the PersistentStore protocol to provide a mock version of Core Data operations,
//  enabling the testing of database interactions without affecting the actual data.
//  It simulates Core Data functionalities such as fetching, fetching a single object, and updating data,
//  and is designed to work seamlessly with Combine for asynchronous operations.
//  The mock store uses a custom ContextSnapshot structure to track changes in the Core Data context,
//  enabling detailed verification of database operations during tests.
//  Additionally, this class includes utility functions for preloading data into the Core Data context
//  and for cleaning up the mock database, ensuring a consistent state for each test.
//  The implementation leverages Swift's language features, like generics and closures, to provide
//  a flexible and powerful mocking mechanism for database interactions.
//
//  Created by Dominic Danborn on 2/27/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import CoreData
import Combine
@testable import Lift_Tracker

final class MockedPersistentStore: Mock, PersistentStore {
    
    struct ContextSnapshot: Equatable {
        let inserted: Int
        let updated: Int
        let deleted: Int
    }
    
    enum Action: Equatable {
        case fetch(ContextSnapshot)
        case fetchOne(ContextSnapshot)
        case update(ContextSnapshot)
    }
    
    var actions = MockActions<Action>(expected: [])
    
    deinit {
        destroyDatabase()
    }
    
    /// Simulates fetching multiple objects of type `T` from the mock Core Data store and maps them to type `V`.
    ///
    /// This mock function is designed for unit testing, allowing you to verify that a bulk fetch operation
    /// is executed correctly without interacting with the actual Core Data store. It uses a provided
    /// fetch request and a mapping closure to simulate fetching and converting multiple objects.
    /// The method captures the result or error and returns it as a publisher for further assertions in tests.
    ///
    /// - Parameters:
    ///   - fetchRequest: An `NSFetchRequest` configured to fetch objects of type `T`.
    ///   - map: A closure that takes an object of type `T` and returns an optional object of type `V`,
    ///          representing the mapped result. This closure may throw an error.
    ///
    /// - Returns: A publisher that emits an array of `V` objects representing the fetched and mapped results,
    ///            or an error if the fetch operation or mapping fails. The result is immediately available
    ///            for testing assertions.
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error> {
        do {
            // Retrieve the view context from the mock persistent container.
            let context = container.viewContext
            
            // Resets the context to ensure it's in a clean state before performing the fetch.
            context.reset()
            
            // Simulate the execution of the fetch request.
            let fetchedObjects = try context.fetch(fetchRequest)
            
            // Apply the mapping closure to each fetched object to convert them to the desired type.
            let mappedResult = try fetchedObjects.compactMap(map)
            
            // Record the fetch operation along with a snapshot of the context state for testing verification.
            register(.fetch(context.snapshot))
            
            // Return a publisher that immediately emits the array of mapped objects.
            return Just(mappedResult).setFailureType(to: Error.self).publish()
        } catch {
            // In case of an error during the fetch operation, return a publisher that emits the encountered error.
            return Fail<[V], Error>(error: error).publish()
        }
    }
    
    /// Simulates fetching a single object of type `T` from the mock Core Data store and maps it to type `V`.
    ///
    /// This mock function is designed for unit testing, allowing you to verify that a fetch operation
    /// is executed correctly without interacting with the actual Core Data store. It uses a provided
    /// fetch request and a mapping closure to simulate fetching and converting a single object.
    /// The method captures the result or error and returns it as a publisher for further assertions in tests.
    ///
    /// - Parameters:
    ///   - fetchRequest: An `NSFetchRequest` configured to fetch objects of type `T`.
    ///   - map: A closure that takes an object of type `T` and returns an optional object of type `V`,
    ///          representing the mapped result. This closure may throw an error.
    ///
    /// - Returns: A publisher that emits an optional `V` object representing the fetched and mapped result,
    ///            or an error if the fetch operation or mapping fails. The result is immediately available
    ///            for testing assertions
    func fetchOne<T, V>(_ fetchRequest: NSFetchRequest<T>, map: @escaping (T) throws -> V?) -> AnyPublisher<V?, Error> where T: NSFetchRequestResult {
        do {
            // Retrieve the view context from the mock persistent container.
            let context = container.viewContext
            
            // Reset the context to ensure it's in a clean state before performing the fetch.
            context.reset()
            
            // Simulate the execution of the fetch request.
            let fetchedObjects = try context.fetch(fetchRequest)
            
            // Check if at least one object is fetched and process it.
            let mappedObject: V? = try fetchedObjects.first.map { try map($0)! }
            
            // Record the fetchOne operation along with a snapshot of the context state for testing verification.
            register(.fetchOne(context.snapshot))
            
            // Return a publisher that immediately emits the mapped object or nil.
            return Just(mappedObject).setFailureType(to: Error.self).publish()
        } catch {
            // In case of an error during the fetch operation, return a publisher that emits the encountered error.
            return Fail<V?, Error>(error: error).publish()
        }
    }
    
    
    /// Executes a database operation and returns its result as a publisher.
    ///
    /// This function simulates a database update operation in a mock persistent store context. It is designed for unit testing,
    /// allowing you to verify database interactions without affecting the actual data. The function executes an operation
    /// closure within a managed object context, captures its result or error, and returns it as a publisher.
    ///
    /// - Parameter operation: A closure representing the database operation. This closure accepts an
    ///         `NSManagedObjectContext` and returns a `Result` type, potentially throwing an error.
    ///
    /// - Returns: A publisher that emits the result of the operation or an error.
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
        do {
            // Retrieves the view context from the mock persistent container.
            let context = container.viewContext
            
            // Resets the context to ensure it's in a clean state before performing the operation.
            context.reset()
            
            // Executes the provided operation closure within the context and captures its result.
            let result = try operation(context)
            
            // Records this update operation along with a snapshot of the context state for testing verification.
            register(.update(context.snapshot))
            
            // Returns a publisher that immediately emits the captured result.
            return Just(result).setFailureType(to: Error.self).publish()
        } catch {
            // In case of an error during the operation, returns a publisher that emits the encountered error.
            return Fail<Result, Error>(error: error).publish()
        }
    }
    
    
    /// Preloads data into the Core Data context for testing purposes.
    ///
    /// This function is designed to set up a specific state in the Core Data database
    /// before running tests. It accepts a closure that performs operations on the Core Data context,
    /// such as inserting, updating, or deleting data. After executing these operations, it saves
    /// any changes to the persistent store and then resets the context to ensure a clean state
    /// for subsequent operations or tests.
    ///
    /// - Parameter preload: A closure that takes an `NSManagedObjectContext` and performs
    ///   data manipulation operations. This closure may throw an error, which will be propagated.
    ///
    /// - Throws: Propagates any errors thrown by either the `preload` closure or by saving the context.
    func preloadData(_ preload: (NSManagedObjectContext) throws -> Void) throws {
        // Execute the provided preload closure with the viewContext of the container.
        // This allows the preload closure to perform data setup operations.
        try preload(container.viewContext)
        
        // Check if there are changes in the context after executing the preload closure.
        if container.viewContext.hasChanges {
            // If there are changes, save them to the persistent store.
            try container.viewContext.save()
        }
        
        // Reset the context after saving the changes.
        // This clears the context's in-memory cache of managed objects,
        // ensuring that future fetch requests retrieve fresh data from the store.
        container.viewContext.reset()
    }
    
    
    // MARK: - Database
    
    // Holds the database version information.
    private let dbVersion = CoreDataStack.Version(CoreDataStack.Version.actual)
    
    /// Computed property to get the URL where the Core Data database file is stored.
    private var dbURL: URL {
        // Attempt to construct the URL for the database file based on the current version.
        // If unable to find the URL, the app will terminate with a fatal error.
        guard let url = dbVersion.dbFileURL(.cachesDirectory, .userDomainMask)
        else { fatalError() }
        return url
    }
    
    /// Lazy-initialized NSPersistentContainer.
    /// Sets up the Core Data stack including the model, context, and the persistent store coordinator.
    private lazy var container: NSPersistentContainer = {
        
        // Create a persistent container with the model name.
        let container = NSPersistentContainer(name: dbVersion.modelName)
        
        // Attempt to delete any existing database file at the target URL.
        // Resets the database state.
        try? FileManager().removeItem(at: dbURL)
        let store = NSPersistentStoreDescription(url: dbURL)
        
        // Create a persistent store description with the URL where the database should be stored.
        container.persistentStoreDescriptions = [store]
        
        // Use a dispatch group to synchronously load the persistent stores.
        let group = DispatchGroup()
        group.enter()
        container.loadPersistentStores { (desc, error) in
            // Check for errors while loading the persistent stores.
            // If an error occurs, terminate the app with a fatal error.
            if let error = error {
                fatalError("\(error)")
            }
            group.leave()
        }
        
        group.wait()
        
        // Configure the view context with specific settings.
        container.viewContext.mergePolicy = NSOverwriteMergePolicy      // Resolve conflicts by overwriting.
        container.viewContext.undoManager = nil                         // Disable the undo manager to improve performance.
        
        return container
    }()
    
    /// Destroys the existing Core Data database.
    /// This function is used to completely remove the database file from disk.
    private func destroyDatabase() {
        
        // Attempt to destroy the persistent store at the given URL.
        try? container.persistentStoreCoordinator
            .destroyPersistentStore(at: dbURL, ofType: NSSQLiteStoreType, options: nil)
        
        // Attempt to remove the database file from the file system.
        try? FileManager().removeItem(at: dbURL)
    }
}

/// Extension to NSManagedObjectContext for tracking context changes.
extension NSManagedObjectContext {
    
    /// Creates a snapshot of the current context state, capturing counts of inserted, updated, and deleted objects.
    /// Useful for debugging or tracking changes in the context over time.
    var snapshot: MockedPersistentStore.ContextSnapshot {
        return .init(
            inserted: insertedObjects.count,        // Count of newly inserted objects.
            updated: updatedObjects.count,          // Count of updated objects.
            deleted: deletedObjects.count           // Count of deleted objects.
        )
    }
}
