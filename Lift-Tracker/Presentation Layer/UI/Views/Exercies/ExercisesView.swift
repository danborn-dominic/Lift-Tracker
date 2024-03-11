//
//  ExercisesView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

struct ExercisesView: View {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
            
        return VStack {
            
        }
    }
    
    
}

// MARK: - Side Effects
private extension ExercisesView {

}
// MARK: - Routing
extension ExercisesView {
    struct Routing: Equatable {
        var exerciseDetails: Exercise.ID?
    }
}
// MARK: - Managing Content
private extension ExercisesView {
    var notRequestedView: some View {
        Text("Not Requested View").onAppear(perform: loadExercises)
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load routines: \(error.localizedDescription)")
            .onTapGesture { self.loadExercises() }
    }
    
    func loadExercises() {
    }
    
    
}

// MARK: - Displaying Content
private extension ExercisesView {
    
}

