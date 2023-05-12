//
//  Lift_TrackerApp.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/12/23.
//

import SwiftUI

@main
struct Lift_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
