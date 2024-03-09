//
//  SystemProtocols.swift
//  Lift-Tracker
//
// Description:
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

/// Protocol defining methods to handle system-level events.
protocol SystemEventsHandler {
    func sceneDidBecomeActive()
    func sceneWillResignActive()
}
