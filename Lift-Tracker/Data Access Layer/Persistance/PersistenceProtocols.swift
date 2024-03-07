//
//  PersistentStoreProtocol.swift
//  Lift-Tracker
//
//  Description:
//  This file defines the PersistentStore protocol, a key component in the Lift-Tracker app for abstracting
//  database operations. The protocol encapsulates core functionalities for interacting with a persistent data store,
//  specifically tailored for a Core Data database in this context. It outlines a series of generic methods
//  for type-safe data fetching and updating. These methods are designed to integrate with Combine, enabling
//  asynchronous database operations and streamlined handling of results and errors. By abstracting these
//  operations into a protocol, the app gains flexibility, allowing for easy swapping of data storage
//  mechanisms or mock implementations for testing purposes.
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import CoreData
import Combine

// PersistentStore protocol.
// This protocol defines the core functionalities for interacting with a persistent store,
// such as a Core Data database. It provides a set of methods for fetching and updating data
// in a type-safe and generic way. The protocol uses Combine to handle asynchronous operations.
protocol PersistentStore {
    // Typealias for a database operation that can throw an error and return a result.
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
    
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>, map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error>
        
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
}
