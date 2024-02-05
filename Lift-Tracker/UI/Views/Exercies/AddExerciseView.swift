//
//  AddExerciseView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/5/24.
//

import SwiftUI

struct AddExerciseView: View {
    private let container: DIContainer
    @State private var exerciseName = ""

    init(container: DIContainer) {
        self.container = container
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Name")) {
                    TextField("Name", text: $exerciseName)
                }
            }
            .navigationBarTitle("Add Exercise", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveExercise()
            })
        }
    }
    
    private func saveExercise() {
    }
}

#if DEBUG
struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(container: .preview)
    }
}
#endif
