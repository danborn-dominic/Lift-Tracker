//
//  Loadable.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/3/23.
//
//  Description:
//  This file defines the Loadable enum, a versatile utility for handling asynchronous data loading states
//  within the Lift-Tracker app. The Loadable type encapsulates various states of a data request, such as not yet requested,
//  loading (with the ability to hold a last known value and a CancelBag for canceling ongoing requests),
//  loaded with data, or failed with an error. It simplifies UI updates and error handling by providing a unified
//  approach to represent and handle data loading states. Its extensions include utility functions for state updates
//  and mapping loaded values, making it integral for async data management in SwiftUI and Combine-based architectures.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// LoadableSubject is a typealias for a SwiftUI Binding that wraps a Loadable type.
typealias LoadableSubject<Value> = Binding<Loadable<Value>>

// Enum defining the Loadable type with generic parameter T.
enum Loadable<T> {
    
    // Represents the state where the data request has not yet been made. Values should start in this state.
    case notRequested
    // Represents the loading state, optionally holding the last known value and a CancelBag for ongoing requests.
    case isLoading(last: T?, cancelBag: CancelBag)
    // Represents the state where data has been successfully loaded.
    case loaded(T)
    // Represents a failed state with an associated Error.
    case failed(Error)
    
    // Computed property to retrieve the current value (if available).
    var value: T? {
        switch self {
        case let .loaded(value): return value       // If loaded, return the value.
        case let .isLoading(last, _): return last   // If loading, return the last known value.
        default: return nil
        }
    }
    
    // Computed property to retrieve the current error (if any).
    var error: Error? {
        switch self {
        case let .failed(error): return error       // If failed, return the error.
        default: return nil
        }
    }
}

extension Loadable {
    /// Sets the Loadable instance to the `.isLoading` state with the given CancelBag.
    ///
    /// - Parameters:
    ///    - cancelBag: The CancelBag used to manage cancellable operations.
    mutating func setIsLoading(cancelBag: CancelBag) {
        // Update the Loadable to 'isLoading' state, retaining the last known value and the provided CancelBag.
        self = .isLoading(last: value, cancelBag: cancelBag)
    }
    
    /// Cancels any ongoing loading operation and sets the Loadable to either the '.loaded' state
    /// with the last known value or to '.failed' state with a cancellation error.
    mutating func cancelLoading() {
        switch self {
        case let .isLoading(last, cancelBag):
            // Cancel any ongoing operations associated with the CancelBag.
            cancelBag.cancel()
            
            // Set to '.loaded' state with the last known value, if available.
            // Otherwise, mark it as '.failed' with a cancellation error.
            if let last = last {
                self = .loaded(last)
            } else {
                let error = NSError(
                    domain: NSCocoaErrorDomain, code: NSUserCancelledError,
                    userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Canceled by user",
                                                                            comment: "")])
                self = .failed(error)
            }
        default:
            // Do nothing if the Loadable is not in the '.isLoading' state.
            break
        }
    }
    
    /// Transforms the Loadable instance to a new Loadable with a different type using the provided transform.
    ///
    /// - Parameters:
    ///    - transform: A closure that takes a value of type `T` and returns a value of type `V`.
    /// - Returns:
    ///     - A Loadable instance of type `V`.
    func map<V>(_ transform: (T) throws -> V) -> Loadable<V> {
        do {
            switch self {
            case .notRequested: 
                return .notRequested
            case let .failed(error):
                return .failed(error)
            case let .isLoading(value, cancelBag):
                // Apply the transform to the 'value' if present, and return a new '.isLoading' Loadable.
                return .isLoading(last: try value.map { try transform($0) },
                                  cancelBag: cancelBag)
            case let .loaded(value):
                // Apply the transform to the 'value' and return a new '.loaded' Loadable.
                return .loaded(try transform(value))
            }
        } catch {
            // If the transform throws an error, return a new '.failed' Loadable with that error.
            return .failed(error)
        }
    }
}

/// Extension to make `Loadable` conform to `Equatable` when its wrapped value is `Equatable`.
extension Loadable: Equatable where T: Equatable {
    /// Compares two `Loadable` instances for equality.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side `Loadable` instance to compare.
    ///   - rhs: The right-hand side `Loadable` instance to compare.
    /// - Returns:
    ///     - A Boolean value indicating whether the two instances are considered equal.
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
            
        case let (.isLoading(lhsV, _), .isLoading(rhsV, _)):
            // Both instances are in the '.isLoading' state. Compare their associated values.
            return lhsV == rhsV
            
        case let (.loaded(lhsV), .loaded(rhsV)):
            // Both instances are in the '.loaded' state. Compare their associated values.
            return lhsV == rhsV
            
        case let (.failed(lhsE), .failed(rhsE)):
            // Both instances are in the '.failed' state. Compare the localized description of their errors.
            return lhsE.localizedDescription == rhsE.localizedDescription
            
        default:
            // All other combinations of states are considered unequal.
            return false
        }
    }
}
