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
        let newExercise = ExerciseStruct(id: UUID(), exerciseName: exerciseName, exerciseNotes: exerciseNotes)
        print("DEBUG Saving exercise from view: ", newExercise)
        container.interactors.exerciseInteractor.addExercise(exercise: newExercise)
        print("DEBUG finished saving exercise, dismissing view")
        self.presentationMode.wrappedValue.dismiss()
    }
}

//#if DEBUG
//struct AddExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExerciseView(container: .preview)
//    }
//}
//#endif
