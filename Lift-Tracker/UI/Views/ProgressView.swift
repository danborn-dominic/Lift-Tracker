//
//  ProgressView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct ProgressView: View {
    
    private let container: DIContainer

    init(container: DIContainer) {
        print("INFO ProgressView init: DIContainer injected")
        self.container = container
    }
    
    var body: some View {
        NavigationView {
        }
            .navigationBarTitle("Progress")
    }
}
