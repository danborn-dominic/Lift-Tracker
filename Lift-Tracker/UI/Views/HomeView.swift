//
//  HomeView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct HomeView: View {
    
    private let container: DIContainer

    init(container: DIContainer) {
        print("INFO HomeView init: DIContainer injected")
        self.container = container
    }
    
    var body: some View {
        // The actual content of your HomeView goes here.
        // NavigationView has been removed.
        Text("Home Content")
            .navigationBarTitle("Home")
    }
}
