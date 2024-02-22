//
//  SceneDelegate.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/9/23.
//
//  Description:
//  The SceneDelegate class handles specific lifecycle events of the UI scene for the Lift-Tracker application.
//  It is responsible for setting up and configuring the UI environment as the application transitions between various states.
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import Foundation

/// SceneDelegate is responsible for managing the lifecycle and UI of the application's scenes.
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var systemEventsHandler: SystemEventsHandler?
    
    /// Called when a new scene session is being created and the application is about to connect to it.
    /// Sets up the initial UI of the application.
    ///
    /// - Parameters:
    ///   - scene: An object representing the contents of a scene.
    ///   - session: The session containing details about the scene's configuration.
    ///   - connectionOptions: Options specifying how to configure the scene.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        let environment = AppEnvironment.bootstrap()
        let contentView = ContentView(container: environment.container)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        self.systemEventsHandler = environment.systemEventsHandler
    }
    
    /// Called when the scene has moved from an inactive state to an active state.
    /// Triggers actions to be taken when the app becomes active.
    ///
    /// - Parameters:
    ///    - scene: An object representing the contents of a scene.
    func sceneDidBecomeActive(_ scene: UIScene) {
        systemEventsHandler?.sceneDidBecomeActive()
    }
    
    /// Called when the scene is about to move from an active state to an inactive state.
    /// Triggers actions to be taken when the app is about to become inactive.
    ///
    /// - Parameters:
    ///    - scene: An object representing the contents of a scene.
    func sceneWillResignActive(_ scene: UIScene) {
        systemEventsHandler?.sceneWillResignActive()
    }
}
