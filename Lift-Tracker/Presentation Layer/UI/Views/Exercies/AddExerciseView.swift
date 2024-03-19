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
    
    @State private var isShowingBodyPartPicker = false
    @State private var isShowingPickerOverlay = false
    @State private var selectedBodyPart: String? = "Any"
    
    let bodyParts: [String] = [
        "Any", "Back", "Biceps", "Calves", "Chest", "Core", "Forearms", "Full Body",
        "Glutes", "Hamstrings", "Quads", "Shoulders", "Triceps", "Other"
    ]
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
                if isShowingBodyPartPicker {
                    blurredBackground
                    pickerOverlay
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var blurredBackground: some View {
        Color.backgroundColor
            .blur(radius: 3)
            .ignoresSafeArea(.all)
    }
    
    private var pickerOverlay: some View {
        BodyPartPickerOverlay(isPresented: $isShowingBodyPartPicker, selectedBodyPart: $selectedBodyPart, bodyParts: bodyParts)
            .background(Color.black.opacity(0.6).edgesIgnoringSafeArea(.all))
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
                    Button(action: {
                        isShowingBodyPartPicker.toggle()
                    }, label: {
                        DropDownField()
                    })
                }
                .padding(.horizontal, 20)
                .frame(width: 390)
            } header: {
                HStack {
                    Text("Body Part")
                    Spacer()
                    Spacer()
                    Text("Category")
                    Spacer()
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
