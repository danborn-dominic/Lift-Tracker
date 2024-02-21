//
//  AddWorkoutView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/16/23.
//

import SwiftUI

struct AddRoutineView: View {
    private let container: DIContainer
    @State private var routineName = ""
    @State private var exercises: [ExerciseStruct] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Name")) {
                    TextField("Name", text: $routineName)
                }
                
                Section(header: Text("Exercises")) {
                    ForEach(exercises.indices, id: \.self) { index in
                        HStack {
                            TextField("Exercise Name", text: $exercises[index].exerciseName)
                            Button(action: {
                                exercises.remove(at: index)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteExercise)
                    
                    Button("Add Exercise") {
                        exercises.append(ExerciseStruct(id: UUID(), exerciseName: ""))
                    }
                }
            }
            .navigationBarTitle("Add Workout", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                saveRoutine()
            })
        }
    }
    
    private func saveRoutine() {
        let newRoutine = RoutineStruct(id: UUID(), routineName: routineName, exercises: exercises)
        container.interactors.routineInteractor.addRoutine(routine: newRoutine)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
}

//#if DEBUG
//struct AddRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRoutineView(container: .preview)
//    }
//}
//#endif
