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
                    if #available(iOS 17.0, *) {
                        dataForm
                    }
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
    
    @available(iOS 17.0, *)
    private var dataForm: some View {
        Form {
            Section {
                SuperTextField(placeholder: Text("Unnamed Exercise").foregroundColor(Color.secondaryTextColor), text: $exerciseName)
                    .foregroundColor(Color.secondaryTextColor)
                    .listRowBackground(Color.componentColor)
            } header: {
                Text("Exercise Name")
                    .foregroundColor(.secondaryTextColor)
            }
            
            Section {
                SuperTextFieldV2(
                    placeholder:
                        Text("")
                            .foregroundColor(Color.secondaryTextColor),
                    text:
                        $notes
                )
                .frame(height: 100)
                .foregroundColor(Color.secondaryTextColor)
                .listRowBackground(Color.componentColor)
            } header: {
                Text("Notes")
                    .foregroundColor(.secondaryTextColor)
            }
            
            Section {
                HStack {
                    SuperTextFieldV3()
                    SuperTextFieldV3()
                }
                
            } header: {
                HStack {
                    Text("Body Part")
                    Spacer()
                    Text("Category")
                }
                .foregroundColor(.secondaryTextColor)
            }
            .listRowBackground(Color.backgroundColor)

            
        }
        .listSectionSpacing(0)
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
