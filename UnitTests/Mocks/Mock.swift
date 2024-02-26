//
//  Mock.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/25/24.
//
//  Created by Dominic Danborn on 2/25/24.
//
//  Description:
//  This file defines the Mock protocol and the MockActions class, which are essential
//  for unit testing in the Lift-Tracker app. The Mock protocol standardizes the way actions
//  are recorded and verified in mock objects, enabling the simulation of component behavior
//  in a controlled testing environment. MockActions manages the recording and verification
//  of these actions, ensuring the expected behavior of mocks aligns with actual behavior during tests.
//  This file facilitates the creation of robust and reliable unit tests by providing tools to
//  mock and assert interactions within the app's components.
//
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
@testable import Lift_Tracker

// Protocol defining a standard structure for mock objects used in unit tests.
protocol Mock {
    // An associated type representing the actions the mock is expected to perform.
    associatedtype Action: Equatable
    
    // A collection of actions recorded and expected from the mock.
    var actions: MockActions<Action> { get }
    
    // Method to record an action performed on the mock.
    func register(_ action: Action)
    
    // Method to verify that performed actions match the expected actions.
    func verify(file: StaticString, line: UInt)
}

// Default implementation of the Mock protocol.
extension Mock {
    // Records an action performed on the mock.
    func register(_ action: Action) {
        actions.register(action)
    }
    
    // Verifies that the actions performed match the expected actions.
    func verify(file: StaticString = #file, line: UInt = #line) {
        actions.verify(file: file, line: line)
    }
}

/// `MockActions` is a utility class used in unit testing to manage and verify the actions performed on a mock object.
/// It compares the expected sequence of actions with the actual sequence performed during the test execution.
/// This class is crucial in ensuring that the mock object's interactions align with the expected behavior in the tests.
///
/// - `Action`: A generic type conforming to `Equatable`. Represents the type of actions that can be performed on the mock object.
///
/// The class maintains two arrays:
/// - `expected`: An array of `Action` instances representing the expected sequence of actions in the test.
/// - `factual`: An array that records the actual actions performed on the mock object during the test execution.
///
/// It provides methods to register actual actions and verify them against the expected sequence,
/// thereby ensuring that the mock object's behavior matches the test's specifications.
///
/// Usage:
/// 1. Initialize `MockActions` with a sequence of expected actions.
/// 2. Use `register(_:)` method to record each action performed on the mock.
/// 3. Call `verify(file:line:)` to compare the recorded actions against the expected sequence.
///    If they don't match, the method triggers a test failure with a detailed message.
///
/// - Important:
///   - This class is intended for use in unit testing scenarios and is typically not used in production code.
///   - It assumes that the order and frequency of actions are significant for the test's correctness.
final class MockActions<Action> where Action: Equatable {
    // An array of actions that are expected to be performed by the mock.
    let expected: [Action]
    
    // An array recording the actual actions performed by the mock.
    var actual: [Action] = []
    
    // Initializes with a set of expected actions.
    init(expected: [Action]) {
        self.expected = expected
    }
    
    // Records an actual action performed by adding to the list.
    fileprivate func register(_ action: Action) {
        actual.append(action)
    }
    
    /// Verifies that the actions performed on the mock match the expected actions.
    /// This method compares the recorded actions (`factual`) with the actions
    /// expected in the test (`expected`). If they don't match, it triggers a
    /// test failure with a detailed message, including both the expected and
    /// actual actions.
    ///
    /// - Parameters:
    ///   - file: The file where the verification is called, used for logging purposes.
    ///   - line: The line number in the file where the verification is called, used for logging.
    fileprivate func verify(file: StaticString, line: UInt) {
        // If the actual actions match the expected ones, no further action is needed.
        if actual == expected { return }
        
        // Convert both factual and expected actions to string representations.
        let factualNames = actual.map { "." + String(describing: $0) }
        let expectedNames = expected.map { "." + String(describing: $0) }
        
        // Trigger a test failure if there's a mismatch, providing detailed information.
        XCTFail("\(name)\n\nExpected:\n\n\(expectedNames)\n\nReceived:\n\n\(factualNames)", file: file, line: line)
    }
    
    /// Computes and returns the name of the MockActions instance.
    /// Extracts the name from the full string description of the class,
    /// typically used for logging and error reporting in the test failure messages.
    private var name: String {
        // Full string description of the MockActions instance.
        let fullName = String(describing: self)
        
        // Splits the full name by the dot character.
        let nameComponents = fullName.components(separatedBy: ".")
        
        // Returns the last component before the final part, or the full name if not found.
        return nameComponents.dropLast().last ?? fullName
    }
}

