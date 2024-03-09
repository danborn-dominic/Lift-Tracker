//
//  MockedSystemEventsHandler.swift
//  UnitTests
//
//  Description:
//  This file contains the MockedSystemEventsInteractor struct, which provides a mock implementation of the SystemEventsHandler protocol.
//  The mock is used in unit testing to simulate system events such as the app becoming active or resigning active without triggering the actual system events.
//  This allows for controlled testing of the app's response to these system events. The mock tracks interactions through an enumerable 'Action' type,
//  capturing each event for verification in unit tests. This approach ensures that the system event handling within the application behaves as expected
//  under different circumstances, contributing to the robustness of the app.
//
//  Created by Dominic Danborn on 3/1/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import SwiftUI
import Combine
@testable import Lift_Tracker

// Mock implementation of SystemEventsHandler for unit testing.
struct MockedSystemEventsInteractor: Mock, SystemEventsHandler {
    
    // Enum to define the actions that can be performed by the SystemEventsHandler.
    enum Action: Equatable {
        case becomeActive
        case resignActive
    }
    
    // Tracks the actions taken by the mock.
    let actions: MockActions<Action>
    
    // Initializes the mock with an expected set of actions for verification.
    init(expected: [Action]) {
        self.actions = .init(expected: expected)
    }
    
    /// Simulates the event where the scene becomes active.
    /// Records the action and provides a stub for testing purposes.
    func sceneDidBecomeActive() {
        register(.becomeActive)
    }
    
    /// Simulates the event where the scene will resign active.
    /// Records the action and provides a stub for testing purposes.
    func sceneWillResignActive() {
        register(.resignActive)
    }
}
