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
    @Environment(\.presentationMode) var presentationMode
    @State private var exerciseName: String = ""
    @State private var notes: String = ""
    @State private var selectedBodyPart: String = "Any"
    @State private var selectedCategory: String = "Any"
    
    let bodyParts = ["Any", "Chest", "Back", "Arms", "Legs", "Shoulders", "Core"]
    let categories = ["Any", "Strength", "Cardio", "Flexibility", "Balance"]
    
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        self.content
    }
    
    @ViewBuilder private var content: some View {
        
        NavigationView {
            ZStack {
                Color.backgroundColor.ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    header
                    dataForm
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.accentColorBlue)
                Text("Exercises")
                    .foregroundColor(Color.accentColorBlue)
            }
        }
    }
    
    private var header: some View {
        Text("New Exercise")
            .font(.title)
            .foregroundColor(Color.primaryTextColor)
    }
    
    private var dataForm: some View {
        Form {
            Section {
                SuperTextField(placeholder: Text("Unnamed Exercise").foregroundColor(Color.secondaryTextColor), text: $exerciseName)
            } header: {
                Text("Exercise Name").foregroundColor(.secondaryTextColor)
            }
            .listRowBackground(Color.componentColor)
            
            Section {
                SuperTextField(placeholder: Text("").foregroundColor(Color.secondaryTextColor), text: $notes)
            } header: {
                Text("Notes").foregroundColor(.secondaryTextColor)
            }
            .listRowBackground(Color.componentColor)
            
            Section(header: Text("Body Part")) {
                Picker("Body Part", selection: $selectedBodyPart) {
                    ForEach(bodyParts, id: \.self) {
                        Text($0)
                    }
                }
                .foregroundColor(.white)
                .pickerStyle(MenuPickerStyle())
            }
            Section(header: Text("Category")) {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .foregroundColor(.white)
                .pickerStyle(MenuPickerStyle())
            }
            Button("Save Exercise") {
                // Action to save exercise
            }
            .foregroundColor(.blue)
            
        }
        .scrollContentBackground(.hidden)
    }
}

#if DEBUG
struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(container: DIContainer.preview)
    }
}
#endif
