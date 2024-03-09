//
//  TestHelpers.swift
//  UnitTests
//
//  Description:
//  This file contains helper methods and extensions for unit testing in the Lift Tracker app.
//
//  Created by Dominic Danborn on 2/27/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import SwiftUI
import Combine
@testable import Lift_Tracker

// MARK: - UI

// Extension to UIColor to create a UIImage of a specified color and size. Useful for UI testing.
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

// MARK: - Result Extensions for Testing

// Extension to `Result` for asserting success cases in tests.
// This is particularly useful for ensuring that a `Result` is a success and its value matches an expected value.
extension Result where Success: Equatable {
    // Asserts that the result is a success and equals the specified value.
    func assertSuccess(value: Success, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(resultValue):
            // If the result is successful, compare its value with the expected value.
            XCTAssertEqual(resultValue, value, file: file, line: line)
        case let .failure(error):
            // If the result is a failure, fail the test with the error message.
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        }
    }
}

// Extension to `Result` for asserting success in void-returning operations.
// This is useful when testing functions that return `Result<Void, Error>`.
extension Result where Success == Void {
    // Asserts that the result is a success.
    func assertSuccess(file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .failure(error):
            // If the result is a failure, fail the test with the error message.
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        case .success:
            // If the result is successful, no further action is needed.
            break
        }
    }
}

// Extension to `Result` for asserting failure cases in tests.
// This is used to ensure that a `Result` is a failure and optionally checks the error message.
extension Result {
    // Asserts that the result is a failure and optionally matches a provided error message.
    func assertFailure(_ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(value):
            // If the result is a success, fail the test indicating an unexpected success.
            XCTFail("Unexpected success: \(value)", file: file, line: line)
        case let .failure(error):
            // If an error message is provided, compare it with the error's localized description.
            if let message = message {
                XCTAssertEqual(error.localizedDescription, message, file: file, line: line)
            }
        }
    }
}

// Extension to `Result` for converting it to a publisher.
// Useful for testing asynchronous code by wrapping a `Result` in a Combine publisher.
extension Result {
    // Converts the result into a Combine publisher.
    func publish() -> AnyPublisher<Success, Failure> {
        return publisher.publish()
    }
}

// Extension to `Publisher` for testing asynchronous operations.
// This allows simulating delays in asynchronous code, useful for unit testing.
extension Publisher {
    // Adds a delay to the publisher and returns it as an `AnyPublisher`.
    func publish() -> AnyPublisher<Output, Failure> {
        delay(for: .milliseconds(10), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - XCTestCase

// Custom implementation of XCTAssertEqual function to compare two equatable values.
// It enhances the basic XCTAssertEqual by allowing the removal of specified prefixes from the descriptions of the values being compared.
func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> T,     // The first value to compare, wrapped in an autoclosure to delay its evaluation.
    _ expression2: @autoclosure () throws -> T,     // The second value to compare, also wrapped in an autoclosure.
    removing prefixes: [String],                    // An array of string prefixes to remove from the description of both values.
    file: StaticString = #file,                     // File information for logging, defaults to the current file.
    line: UInt = #line                              // Line information for logging, defaults to the current line.
) where T: Equatable {
    do {
        // Evaluate both expressions and assign their values.
        let exp1 = try expression1()
        let exp2 = try expression2()
        
        // Check if the two values are not equal.
        if exp1 != exp2 {
            // Process the description of the first value, removing specified prefixes.
            let desc1 = prefixes.reduce(String(describing: exp1), { (str, prefix) in
                str.replacingOccurrences(of: prefix, with: "")
            })
            
            // Process the description of the second value, removing specified prefixes.
            let desc2 = prefixes.reduce(String(describing: exp2), { (str, prefix) in
                str.replacingOccurrences(of: prefix, with: "")
            })
            
            // If the values are not equal, fail the test with a detailed message.
            XCTFail("XCTAssertEqual failed:\n\n\(desc1)\n\nis not equal to\n\n\(desc2)", file: file, line: line)
        }
    } catch {
        // Catch any exceptions thrown by the autoclosures and fail the test with the error.
        XCTFail("Unexpected exception: \(error)")
    }
}


// Protocol to enable types to remove prefixes from their string representation in custom assertions.
protocol PrefixRemovable { }

// Extension on the PrefixRemovable protocol.
extension PrefixRemovable {
    // Computed property to get a list of prefixes associated with the type.
    static var prefixes: [String] {
        // Reflecting on the type to get its fully qualified name including the module.
        let name = String(reflecting: Self.self)
        // Splitting the name into components based on the dot separator.
        var components = name.components(separatedBy: ".")
        // Extracting the module name and removing it from the components.
        let module = components.removeFirst()
        // Joining the remaining components to form the full type name without the module.
        let fullTypeName = components.joined(separator: ".")
        // Returning a list of prefixes to be removed, based on the module and type names.
        return [
            "\(module).",                                // The module prefix.
            "Loadable<\(fullTypeName)>",                 // The Loadable wrapper prefix.
            "Loadable<LazyList<\(fullTypeName)>>"        // The Loadable wrapper for LazyList prefix.
        ]
    }
}

// MARK: - BindingWithPublisher

// Structure for creating a SwiftUI Binding that records its updates.
// This is particularly useful for testing view models in SwiftUI.
struct BindingWithPublisher<Value> {
    
    let binding: Binding<Value>            // The SwiftUI Binding instance.
    let updatesRecorder: AnyPublisher<[Value], Never> // Publisher that records the updates to the binding.
    
    init(value: Value, recordingTimeInterval: TimeInterval = 0.5) {
        var value = value   // Local copy of the value for the binding.
        var updates = [value] // Array to record the updates.
        
        // Initializing the binding.
        binding = Binding<Value>(
            get: { value },   // Getter returns the current value.
            set: { newValue in
                value = newValue; // Setter updates the value.
                updates.append(newValue) // Record the new value.
            })
        
        // Setting up the updates recorder as a publisher.
        updatesRecorder = Future<[Value], Never> { completion in
            // Asynchronously send the recorded updates after the specified interval.
            DispatchQueue.main.asyncAfter(deadline: .now() + recordingTimeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher() // Erasing to AnyPublisher for more flexible usage.
    }
}

// MARK: - Error

// Enumeration of mock errors for use in unit tests.
enum MockError: Swift.Error {
    case valueNotSet     // Error case for when a required value has not been set.
    case codeDataModel   // Error case for issues related to data models.
}

// Extension to NSError to provide a generic test error.
extension NSError {
    // Computed property to generate a generic test error.
    static var test: NSError {
        return NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"])
    }
}
