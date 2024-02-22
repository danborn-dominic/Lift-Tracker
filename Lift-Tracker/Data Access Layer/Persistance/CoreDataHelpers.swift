//
//  CoreDataHelpers.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/29/23.
//
//  Description:
//  This file contains a collection of extensions and helper methods designed to enhance
//  and simplify the interaction with CoreData in the Lift-Tracker app. It includes utilities
//  for creating new managed objects, configuring Core Data contexts, and converting sets
//  to typed arrays. These helpers aim to reduce boilerplate code and improve readability
//  and maintainability of CoreData related operations.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import CoreData

// MARK: - ManagedEntity

// Protocol to streamline the creation of new managed objects.
protocol ManagedEntity: NSFetchRequestResult { }

extension ManagedEntity where Self: NSManagedObject {
    // Returns the entity name as a string.
    static var entityName: String {
        return String(describing: Self.self)
    }
    
    // Inserts a new instance of the managed object into the specified context.
    static func insertNew(in context: NSManagedObjectContext) -> Self? {
        return NSEntityDescription
            .insertNewObject(forEntityName: entityName, into: context) as? Self
    }
}

extension NSManagedObjectContext {
    // Configures the context for read-only operations.
    func configureAsReadOnlyContext() {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSRollbackMergePolicy
        undoManager = nil
        shouldDeleteInaccessibleFaults = true
    }
    
    // Configures the context for update operations.
    func configureAsUpdateContext() {
        mergePolicy = NSOverwriteMergePolicy
        undoManager = nil
    }
}

// MARK: - Misc

extension NSSet {
    // Converts an NSSet to a typed array.
    func toArray<T>(of type: T.Type) -> [T] {
        allObjects.compactMap { $0 as? T }
    }
}
