//
//  SystemEventsHandler.swift
//  Lift-Tracker
//
//  Description:
//  Defines the SystemEventsHandler protocol and its concrete implementation. This protocol is responsible
//  for handling system-level events such as the application becoming active or resigning active. The RealSystemEventsHandler
//  class uses the DIContainer to manage the state of the application in response to these system events.
//
//  Created by Dominic Danborn on 6/13/23.
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import UIKit
import Combine

/// Concrete implementation of SystemEventsHandler.
/// This class updates the application's active state when the scene becomes active or resigns active.
struct RealSystemEventsHandler: SystemEventsHandler {
    
    let container: DIContainer
    private var cancelBag = CancelBag()
    
    /// Initializes the handler with a dependency injection container.
    init(container: DIContainer) {
        self.container = container
    }
    
    /// Handles the event when the scene becomes active.
    /// Sets the application's active state to true.
    func sceneDidBecomeActive() {
        container.appState[\.system.isActive] = true
    }
    
    /// Handles the event when the scene is about to resign active.
    /// Sets the application's active state to false.
    func sceneWillResignActive() {
        container.appState[\.system.isActive] = false
    }
}
