//
//  Store.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/30/23.
//
//  Description:
//  This file defines the DataStore, a type of CurrentValueSubject for state management within the app.
//  It includes extensions for key path based state updates, bulk updates, and SwiftUI Binding modifications.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

// A typealias for a state store using CurrentValueSubject.
typealias DataStore<State> = CurrentValueSubject<State, Never>

extension DataStore {
    /// A subscript extension for CurrentValueSubject that allows direct access
    /// and modification of its Output value's properties using a key path.
    ///
    /// `Parameters:
    ///   - `keyPath`: A WritableKeyPath pointing to a specific property of the Output type.
    ///
    /// `Returns:
    ///   - A property of type `T`, where `T` is the type of the property at the specified key path.
    ///
    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
        // Getter for the property at the specified key path.
        get { value[keyPath: keyPath] }
        // Setter for the property at the specified key path.
        set {
            var value = self.value
            if value[keyPath: keyPath] != newValue {
                // Update the property at the specified key path with the new value.
                value[keyPath: keyPath] = newValue
                // Update the CurrentValueSubject's value with the modified value.
                self.value = value
            }
        }
    }
    
    /// Performs a bulk update on the CurrentValueSubject's value.
    ///
    /// This method allows for multiple changes to be made to the value in a single transaction.
    /// It is useful when you want to update several properties at once while avoiding multiple
    /// updates being sent to the subscribers.
    ///
    /// - Parameters:
    ///    - update: A closure that takes an `inout` reference to the `Output` (CurrentValueSubject's value)
    ///                     and performs the desired updates.
    ///
    func bulkUpdate(_ update: (inout Output) -> Void) {
        // Copy the current value to allow modification.
        var value = self.value
        // Execute the provided closure, passing in the reference to the copied value.
        // This allows the closure to make multiple changes to the value.
        update(&value)
        // After the closure completes, update the CurrentValueSubject's value with
        // the modified value, effectively applying all the changes at once.
        self.value = value
    }
    
    /// Creates a publisher that emits values of a specific type whenever the specified property changes.
    ///
    /// This method is an extension on `CurrentValueSubject` and is useful for observing specific
    /// properties of the `CurrentValueSubject`'s `Output`. It emits only when the observed property changes.
    ///
    /// - Parameters:
    ///    - keyPath: A key path of the `Output` type pointing to the property to observe.
    /// - Returns:
    ///    - A publisher that emits values of the property type whenever the property changes.
    ///
    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
    AnyPublisher<Value, Failure> where Value: Equatable {
        return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}

// MARK: - SwiftUI Binding Extensions

extension Binding where Value: Equatable {
    /// Returns a binding that updates a specific property in a `CurrentValueSubject` state whenever the binding's value changes.
    ///
    /// This extension on `Binding` is useful when the value of the binding needs to trigger an update in a specific
    /// property of a shared state object managed by a `CurrentValueSubject`. The binding's value is dispatched
    /// to the specified property in the state whenever it changes.
    ///
    /// - Parameters:
    ///   - state: A reference to the `CurrentValueSubject` that manages the shared state.
    ///   - keyPath: A writable key path from the `CurrentValueSubject`'s `Output` to the property that should be updated.
    /// - Returns:
    ///     - A new binding that updates the specified property in the state when its value changes.
    ///
    func dispatched<State>(to state: DataStore<State>,
                           _ keyPath: WritableKeyPath<State, Value>) -> Self {
        // Creates a new binding that, when set, updates the specified property in the provided state.
        // The 'onSet' closure updates the state's property specified by keyPath with the binding's new value.
        return onSet { state[keyPath] = $0 }
    }
}

extension Binding where Value: Equatable {
    typealias ValueClosure = (Value) -> Void
    
    /// Creates a binding that executes a closure each time the binding's value is set.
    ///
    /// This extension on `Binding` allows additional actions to be performed when a new value is set to the binding.
    /// The provided closure is called with the new value as a parameter. This is useful for situations where you want
    /// to trigger side effects in response to a value change in the binding.
    ///
    /// - Parameters:
    ///    - perform: A closure that takes the new value of the binding as its parameter.
    /// - Returns:
    ///     - A modified binding that executes the provided closure each time its value is set.
    ///
    func onSet(_ perform: @escaping ValueClosure) -> Self {
        // Creates a new binding instance.
        // When the value is set, it checks if the value is different from the current value.
        // If different, it updates the wrapped value and executes the provided closure.
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            if self.wrappedValue != value {
                self.wrappedValue = value
            }
            // Execute the closure with the new value.
            perform(value)
        })
    }
}
