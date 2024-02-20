//
//  SceneDelegate.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/9/23.
//
//

import UIKit
import SwiftUI
import Combine
import Foundation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var systemEventsHandler: SystemEventsHandler?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        print("INFO setting up scene")
        let environment = AppEnvironment.bootstrap()
        let contentView = ContentView(container: environment.container)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        self.systemEventsHandler = environment.systemEventsHandler
        print("INFO done setting up scene")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("INFO scene active")
        systemEventsHandler?.sceneDidBecomeActive()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        systemEventsHandler?.sceneWillResignActive()
    }
}
