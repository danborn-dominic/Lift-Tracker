////
////  idk.swift
////  Lift-Tracker
////
////  Created by Dominic Danborn on 3/18/24.
////
//
//import Foundation
//
//import SwiftUI
//
//struct AddExerciseView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var exerciseName: String = ""
//    @State private var notes: String = ""
//    @State private var selectedBodyPart: String = "Any"
//    @State private var selectedCategory: String = "Any"
//    
//    let bodyParts = ["Any", "Chest", "Back", "Arms", "Legs", "Shoulders", "Core"]
//    let categories = ["Any", "Strength", "Cardio", "Flexibility", "Balance"]
//    
//    var body: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//            VStack(spacing: 0) {
//                header
//                Form {
//                    Section(header: Text("Exercise Name")) {
//                        TextField("Unnamed Exercise", text: $exerciseName)
//                            .foregroundColor(.white)
//                    }
//                    Section(header: Text("Notes")) {
//                        TextField("", text: $notes)
//                            .foregroundColor(.white)
//                    }
//                    Section(header: Text("Body Part")) {
//                        Picker("Body Part", selection: $selectedBodyPart) {
//                            ForEach(bodyParts, id: \.self) {
//                                Text($0)
//                            }
//                        }
//                        .foregroundColor(.white)
//                        .pickerStyle(MenuPickerStyle())
//                    }
//                    Section(header: Text("Category")) {
//                        Picker("Category", selection: $selectedCategory) {
//                            ForEach(categories, id: \.self) {
//                                Text($0)
//                            }
//                        }
//                        .foregroundColor(.white)
//                        .pickerStyle(MenuPickerStyle())
//                    }
//                    Button("Save Exercise") {
//                        // Action to save exercise
//                    }
//                    .foregroundColor(.blue)
//                }
//                .background(Color.black)
//            }
//            .foregroundColor(.white)
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: backButton)
//    }
//    
//    private var header: some View {
//        Text("New Exercise")
//            .font(.largeTitle)
//            .bold()
//            .padding()
//            .frame(maxWidth: .infinity, alignment: .center)
//            .foregroundColor(.white)
//            .background(Color.black)
//    }
//    
//    private var backButton: some View {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "chevron.left")
//                Text("Exercises")
//            }
//            .foregroundColor(.blue)
//        }
//    }
//}
