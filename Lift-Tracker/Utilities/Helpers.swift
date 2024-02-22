//
//  Helpers.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/23/23.
//
//  Description:
//  This file contains a collection of utility extensions and helper functions designed to
//  enhance the functionality of Combine and SwiftUI. These extensions provide streamlined
//  ways to transform, handle, and manage publishers and subscriptions within the app. Key
//  features include error handling, publisher transformations, and convenience methods for
//  dealing with common asynchronous patterns. These helpers are designed to simplify and
//  reduce boilerplate code in Combine-based asynchronous operations.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

// Extension for Just publisher when its Output is Void.
extension Just where Output == Void {
    /// Creates a publisher that emits a void value and can fail with a specified error type.
    ///
    /// - Parameters:
    ///    - errorType: The type of error the publisher can potentially fail with.
    /// - Returns:
    ///     - A publisher that emits a void value and has the specified error type.
    static func withErrorType<E>(_ errorType: E.Type) -> AnyPublisher<Void, E> {
        return withErrorType((), E.self)
    }
}

// Extension for Just publisher.
extension Just {
    /// Creates a publisher that emits an output value and can fail with a specified error type.
    ///
    /// - Parameters:
    ///   - value: The value to be emitted by the publisher.
    ///   - errorType: The type of error the publisher can potentially fail with.
    /// - Returns:
    ///     - A publisher that emits the provided value and has the specified error type.
    static func withErrorType<E>(_ value: Output, _ errorType: E.Type
    ) -> AnyPublisher<Output, E> {
        return Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }
}

// Extension for publisher types in Combine.
extension Publisher {
    /// Subscribes to the publisher and converts its output into a `Result` type.
    /// The `sinkToResult` function provides a convenient way to handle both success and failure cases from a publisher.
    /// This is useful when you want to process the result of a publisher in a way that is consistent with handling Swift `Result` types.
    ///
    /// - Parameters:
    ///    - result: A closure that is invoked with a `Result` type capturing the output or failure of the publisher.
    /// - Returns:
    ///     - A cancellable instance, which you use when you end assignment of the received value.
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            // Handle the completion of the subscription
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default:
                break
            }
        }, receiveValue: { value in
            // When a new value is received, pass it in the result as a success
            result(.success(value))
        })
    }
    
    /// Subscribes to the publisher and converts its output into a `Loadable` type.
    /// The `sinkToLoadable` function provides a convenient way to handle the output of a publisher in terms of `Loadable` states,
    /// making it suitable for UI data binding where loading, success, and failure states need to be distinctly handled.
    ///
    /// - Parameters:
    ///    - completion: A closure that is invoked with a `Loadable` type capturing the loaded value or failure of the publisher.
    /// - Returns:
    ///     - A cancellable instance, which you use when you end assignment of the received value.
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            // Process the completion state of the subscription
            switch subscriptionCompletion {
            case let .failure(error):
                // If the subscription completes with failure, pass the error in a Loadable.failed state
                completion(.failed(error))
            default:
                // Do nothing if the subscription completes successfully without emitting a value
                break
            }
        }, receiveValue: { value in
            // When a new value is received, pass it in a Loadable.loaded state
            completion(.loaded(value))
        })
    }
    
    /// Extracts the underlying error from a failure if it exists.
    /// This function is useful when dealing with errors that may have underlying causes.
    /// It attempts to extract and forward the underlying error, providing more specific information about the failure.
    ///
    /// - Returns:
    ///     - A publisher that maps any encountered error to its underlying error if available.
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            // Attempts to cast the error to NSError and extract its underlying error.
            // If the underlying error is of the same type as Failure, it is returned.
            // Otherwise, the original error is returned.
            ($0.underlyingError as? Failure) ?? $0
        }
    }
    
    /// Ensures that the publisher completes after a minimum specified time interval.
    /// This function is especially useful when you want to ensure a minimum display time for a loading indicator,
    /// preventing it from disappearing too quickly if the data loads faster than expected.
    ///
    /// - Parameters:
    ///    - interval: The minimum duration of time (in seconds) that the publisher should take to complete.
    /// - Returns:
    ///     - A publisher that delays emitting values and completion until the specified time interval has passed.
    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        // Creates a timer that emits a Void value after the specified interval.
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        // Combines the output of the original publisher with the timer.
        // The value from the original publisher is only emitted after the timer completes.
        return zip(timer)
            .map { $0.0 }               // Extracts and forwards the original publisher's value.
            .eraseToAnyPublisher()
    }
}

private extension Error {
    /// Extracts the underlying error from an NSError.
    var underlyingError: Error? {
        let nsError = self as NSError
        // Checks if the error domain is network related and specific to being offline.
        // If the error indicates an offline status, it's returned directly, as it's self-explanatory.
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // -1009 is the code for "The Internet connection appears to be offline."
            return self
        }
        // Attempts to retrieve the underlying error from the userInfo dictionary of NSError.
        // This is often where more detailed or specific error information is stored.
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}

extension Subscribers.Completion {
    /// Extracts the error from a Completion event if it's a failure.
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
