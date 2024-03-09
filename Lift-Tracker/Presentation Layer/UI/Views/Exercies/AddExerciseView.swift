//
//  AddExerciseView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/5/24.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI

struct AddExerciseView: View {
    private let container: DIContainer
    @State private var exerciseName = ""
    @State private var exerciseNotes = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Name")) {
                    TextField("Unnamed Exercise", text: $exerciseName)
                }
                Section(header: Text("Notes")) {
                    TextField("", text: $exerciseNotes)
                }
            }
            .navigationBarTitle("Add Exercise", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveExercise()
            })
        }
    }
    
    private func saveExercise() {
        let newExercise = Exercise(id: UUID(), exerciseName: exerciseName, exerciseNotes: exerciseNotes)
        container.interactors.exerciseInteractor.addExercise(exercise: newExercise)
        self.presentationMode.wrappedValue.dismiss()
    }
}
