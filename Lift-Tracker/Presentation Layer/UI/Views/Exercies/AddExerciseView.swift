//
//  AddExerciseViewv2.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/22/24.
//

import SwiftUI
import Combine

struct AddExerciseView: View {
    private let container: DIContainer
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var exerciseName: String = ""
    @State private var notes: String = ""
    
    @State private var isShowingBodyPartPicker = false
    @State private var selectedBodyPart: String = "Any"
    
    @State private var isShowingCategoryPicker = false
    @State private var selectedCategory: String = "Any"
    
    let bodyParts: [String] = MuscleGroup.allDisplayNames
    let categories: [String] = ExerciseType.allDisplayNames
    
    
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
                    Spacer()
                }
                if isShowingBodyPartPicker {
                    bodyPartPickerOverlay
                }
                if isShowingCategoryPicker {
                    categoryPickerOverlay
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}

// MARK: - Managing Content

private extension AddExerciseView {
    
    func saveExercise() -> AnyPublisher<Void, Error> {
        let newExercise = Exercise(
            id: UUID(),
            exerciseName: exerciseName,
            exerciseNotes: notes,
            muscleGroup: MuscleGroup(rawValue: MuscleGroup.allCases.first(where: { $0.displayName == selectedBodyPart })?.rawValue ?? 0) ?? .undefined,
            exerciseType: ExerciseType(rawValue: ExerciseType.allCases.first(where: { $0.displayName == selectedCategory })?.rawValue ?? 0) ?? .undefined
        )
        
        return container.interactors.exerciseInteractor.addExercise(exercise: newExercise)
    }
}

// MARK: - Displaying Content

private extension AddExerciseView {
    
    private var bodyPartPickerOverlay: some View {
        ZStack {
            Color.backgroundColor
                .opacity(0.8)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isShowingBodyPartPicker = false
                }
            BodyPartPickerOverlay(isPresented: $isShowingBodyPartPicker, selectedBodyPart: $selectedBodyPart, bodyParts: bodyParts)
        }
    }
    
    private var categoryPickerOverlay: some View {
        ZStack {
            Color.backgroundColor
                .opacity(0.8)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isShowingCategoryPicker = false
                }
            CategoryPickerOverlay(isPresented: $isShowingCategoryPicker, selectedCategory: $selectedCategory, categories: categories)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            if !exerciseName.isEmpty {
                saveExercise()
            }
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
        HStack {
            Spacer()
            Text("New Exercise")
                .font(.title)
                .foregroundColor(Color.primaryTextColor)
            Spacer()
        }
        .padding(.top, -50)
    }
    
    private var dataForm: some View {
        VStack(spacing: 10) {
            StyledTextField(labelText: "Exercise Name", placeholder: Text("Unnamed Exercise"), text: $exerciseName, width: 356, height: 40, labelPadding: -2)
            
            StyledTextFieldWithTextTopLeft(labelText: "Notes", placeholder: Text("Some notes"), text: $notes, width: 356, height: 140, labelPadding: -2)
            
            
            HStack {
                StyledDropdownButton(labelText: "Body Part", displayText: selectedBodyPart, labelPadding: -2) {
                    isShowingBodyPartPicker.toggle()
                }
                .padding(.leading, 20)
                
                StyledDropdownButton(labelText: "Category", displayText: selectedCategory, labelPadding: -2) {
                    isShowingCategoryPicker.toggle()
                }
                .padding(.leading, 10)
            }
            
        }
    }
}

#if DEBUG
struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(container: DIContainer.preview)
    }
}
#endif
