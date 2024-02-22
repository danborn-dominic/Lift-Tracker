//
//  AppDelegate.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/9/23.
//
//  Description:
//  This file defines the AppDelegate class for the Lift-Tracker application.
//  It serves as the primary entry point for the application's lifecycle events,
//  managing and responding to system-wide events such as app launch.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import UIKit

/// The AppDelegate class responsible for handling application-level events.
/// This class is configured to respond to various stages of the application lifecycle.
@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// Lazy-initialized system events handler for the application.
    lazy var systemEventsHandler: SystemEventsHandler? = {
        self.systemEventsHandler(UIApplication.shared)
    }()
    
    /// Called when the application finishes launching.
    /// Here, any initial setup or configurations can be done.
    ///
    /// - Parameters:
    ///   - application: The singleton app instance.
    ///   - launchOptions: A dictionary indicating the reason the app was launched.
    /// - Returns:
    ///     - Boolean indicating whether the application launch was successful.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    /// Retrieves the system events handler from the scene delegate.
    ///
    /// - Parameters:
    ///    - application: The singleton app instance.
    /// - Returns:
    ///     - An optional SystemEventsHandler instance.
    private func systemEventsHandler(_ application: UIApplication) -> SystemEventsHandler? {
        return sceneDelegate(application)?.systemEventsHandler
    }
    
    /// Extracts the scene delegate from the application's windows.
    ///
    /// - Parameters:
    ///    - application: The singleton app instance.
    /// - Returns:
    ///     - An optional SceneDelegate instance.
    private func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        return application.windows
            .compactMap({ $0.windowScene?.delegate as? SceneDelegate })
            .first
    }
}
