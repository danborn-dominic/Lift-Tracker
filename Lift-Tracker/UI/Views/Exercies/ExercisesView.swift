//
//  ExercisesView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//

import SwiftUI

struct ExercisesView: View {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        print("INFO ExercisesView init: DIContainer injected")
        self.container = container
    }
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Exercises")
                        .font(.largeTitle)
                        .bold()
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        Text("Exercises content")
    }
}

#if DEBUG
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(container: .preview)
    }
}
#endif
