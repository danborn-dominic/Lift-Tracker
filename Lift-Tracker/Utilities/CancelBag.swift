//
//  CancelBag.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/3/23.
//
//  Description:
//  This file defines the CancelBag class, a convenience wrapper for managing a collection
//  of AnyCancellable objects. It simplifies the process of canceling multiple subscriptions
//  by storing them in a single bag that can be easily cleared.

//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import Foundation
import Combine

/// A class for managing a collection of subscriptions (`AnyCancellable` objects).
final class CancelBag {
    /// A set of subscriptions managed by the CancelBag.
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    /// Cancels all subscriptions and removes them from the bag.
    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    /// Stores this `AnyCancellable` instance in the provided `CancelBag`.
    ///
    /// - Parameters:
    ///    - cancelBag: The `CancelBag` in which to store this `AnyCancellable`.
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
