//
//  AddWorkoutView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 6/16/23.
//

import SwiftUI

struct AddWorkoutView: View {
    @State private var workoutName = ""
    @State private var exercises: [ExerciseStruct] = [ExerciseStruct]()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.injected) private var injected: DIContainer

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout")) {
                    TextField("Name", text: $workoutName)
                }

                ForEach(exercises.indices, id: \.self) { index in
                    Section(header: Text("Exercise \(index + 1)")) {
                        TextField("Name", text: $exercises[index].name)
                        ForEach(exercises[index].sets.indices, id: \.self) { setIndex in
                            HStack {
                                TextField("Repetitions", value: $exercises[index].sets[setIndex].repetitions, formatter: NumberFormatter())
                                TextField("Weight", value: $exercises[index].sets[setIndex].weight, formatter: NumberFormatter())
                            }
                        }
                        Button("Add Set") {
                            exercises[index].sets.append(SetStruct())
                        }
                    }
                }

                Button("Add Exercise") {
                    exercises.append(ExerciseStruct(name: ""))
                }
            }
                .navigationBarTitle("Add Workout", displayMode: .inline)
                .navigationBarItems(trailing: Button("Save") {
                saveWorkout()
            })
        }
    }

    private func saveWorkout() {
        let newWorkout = WorkoutStruct(name: workoutName, exercises: exercises)
        print("INFO saving workout: ", newWorkout)
        self.injected.interactors.workoutInteractor.addWorkout(workout: newWorkout)
        self.presentationMode.wrappedValue.dismiss()
    }
}


