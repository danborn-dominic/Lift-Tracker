//
//  SettingsView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct SettingsView: View {
    
    private let container: DIContainer

    init(container: DIContainer) {
        print("INFO SettingsView init: DIContainer injected")
        self.container = container
    }
    
    var body: some View {
        NavigationView {
        }
            .navigationBarTitle("Settings")
    }
}
