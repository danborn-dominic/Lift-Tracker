//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Your Name on Today's Date.
//  Copyright (c) 2023 Your Name. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    var body: some View {
        WorkoutListView()
            .inject(container)
    }
}

