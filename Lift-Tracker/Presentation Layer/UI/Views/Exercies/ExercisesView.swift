//
//  ExercisesView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 7/21/23.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI
import Combine

struct ExercisesView: View {
    
    @State private var exerciseData: [Exercise] = ExerciseData.all
    
    private let container: DIContainer
    
    @State private var selectedBodyPart: MuscleGroup = .undefined
    @State private var selectedCategory: ExerciseType = .undefined
    
    @State private var isShowingBodyPartPicker: Bool = false
    @State private var isShowingCategoryPicker: Bool = false
    
    @State private var selectedBodyPartFilter: String = "Body Part"
    @State private var selectedCategoryFilter: String = "Category"
    
    let bodyParts: [String] = [
        "Any", "Back", "Biceps", "Calves", "Chest", "Core", "Forearms", "Full Body",
        "Glutes", "Hamstrings", "Quads", "Shoulders", "Triceps", "Other"
    ]
    
    let categories: [String] = [
        "Any", "Body Weight", "Barbell", "Cardio", "Dumbbell", "Machine", "Other"
    ]
    
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        self.content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Exercises")
                        .font(.title)
                        .bold()
                        .foregroundColor(.secondaryTextColor)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddExerciseView(container: container)
                        .modifier(RootViewAppearance())
                    ) {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(Color.accentColorBlue)
                }
            }
    }
    
    @ViewBuilder private var content: some View {
        VStack(spacing: 10) {
            searchBar
                .padding(.horizontal)
            filters
                .padding(.horizontal)
            exercises
        }
        .padding(.top, 100)
        
        if isShowingBodyPartPicker {
            bodyPartPickerOverlay
        }
        if isShowingCategoryPicker {
            categoryPickerOverlay
        }
    }
    
    private var searchBar: some View {
        ZStack {
            Rectangle()
                .fill(Color.componentColor)
                .frame(width: 356, height: 34)
                .cornerRadius(8);
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.secondaryTextColor)
                Text("Search")
                    .foregroundColor(Color.secondaryTextColor)
                Spacer()
            }
            .padding(.leading, 30)
        }
    }
    
    private var filters: some View {
        HStack {
            ZStack {
                Button(action: {
                    isShowingBodyPartPicker.toggle()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(selectedBodyPartFilter != "Body Part" ? Color.selectedColor : Color.componentColor)
                            .frame(width: 114, height: 24)
                            .cornerRadius(8)
                        Text(selectedBodyPartFilter)
                            .foregroundColor(selectedBodyPartFilter != "Body Part" ? Color.accentColorBlue : Color.secondaryTextColor)
                            .font(.system(size: 12))
                    }
                })
            }
            
            ZStack {
                Button(action: {
                    isShowingCategoryPicker.toggle()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(selectedCategoryFilter != "Category" ? Color.selectedColor : Color.componentColor)
                            .frame(width: 114, height: 24)
                            .cornerRadius(8)
                        Text(selectedCategoryFilter)
                            .foregroundColor(selectedCategoryFilter != "Category" ? Color.accentColorBlue : Color.secondaryTextColor)
                            .font(.system(size: 12))
                    }
                })
            }
            
            ZStack {
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.componentColor)
                            .frame(width: 114, height: 24)
                            .cornerRadius(8)
                        Text("Recent")
                            .foregroundColor(Color.secondaryTextColor)
                            .font(.system(size: 12))
                    }
                })
            }
        }
    }
    
    private var exercises: some View {
        VStack {
            HStack {
                Text("All Exercises")
                    .foregroundColor(Color.secondaryTextColor)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 0))
                Spacer()
            }
            ScrollView {
                LazyVStack(spacing: 6) { // Add some spacing between your cards
                    ForEach(filteredExercises()) { exercise in
                        ExerciseCardView(
                            exerciseName: exercise.exerciseName,
                            bodyPart: exercise.muscleGroup.displayName,
                            equipment: exercise.exerciseType.displayName,
                            weight: "\(exercise.maxWeight) lbs",
                            reps: "\(exercise.repsForMaxWeight) reps"
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 12))
            }
            .padding(.bottom, 90)
        }
    }
    
    private var bodyPartPickerOverlay: some View {
        ZStack {
            Color.backgroundColor
                .opacity(0.8)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isShowingBodyPartPicker = false
                }
            BodyPartPickerOverlay(isPresented: $isShowingBodyPartPicker, selectedBodyPart: $selectedBodyPartFilter, bodyParts: bodyParts)
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
            CategoryPickerOverlay(isPresented: $isShowingCategoryPicker, selectedCategory: $selectedCategoryFilter, categories: categories)
        }
    }
    
}

// MARK: - Side Effects
private extension ExercisesView {
    
}

// MARK: - Routing
extension ExercisesView {
    struct Routing: Equatable {
        var exerciseDetails: Exercise.ID?
    }
}

// MARK: - Managing Content
private extension ExercisesView {
    var notRequestedView: some View {
        Text("Not Requested View").onAppear(perform: loadExercises)
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load routines: \(error.localizedDescription)")
            .onTapGesture { self.loadExercises() }
    }
    
    func loadExercises() {
    }
    
    private func filteredExercises() -> [Exercise] {
        let selectedMuscleGroup = muscleGroup(for: selectedBodyPartFilter)
        let selectedExType = exerciseType(for: selectedCategoryFilter)
        
        return exerciseData.filter { exercise in
            (selectedMuscleGroup == .undefined || exercise.muscleGroup == selectedMuscleGroup) &&
            (selectedExType == .undefined || exercise.exerciseType == selectedExType)
        }
    }
}

private extension ExercisesView {
    func muscleGroup(for filter: String) -> MuscleGroup {
        switch filter {
        case "Chest": return .chest
        case "Back": return .back
        case "Triceps": return .triceps
        case "Biceps": return .biceps
        case "Forearms": return .forearms
        case "Shoulders": return .shoulders
        case "Quads": return .quads
        case "Hamstrings": return .hamstrings
        case "Glutes": return .glutes
        case "Calves": return .calves
        case "Core": return .core
        case "FullBody": return .fullBody
        case "Other": return .other
            
        default: return .undefined
        }
    }
    
    func exerciseType(for filter: String) -> ExerciseType {
        switch filter {
        case "Dumbbell": return .dumbbell
        case "Barbell": return .barbell
        case "Machine": return .machine
        case "Cable": return .cable
        case "Freeweight": return .freeweight
        case "Body Weight": return .bodyWeight
        case "Cardio": return .cardio
        case "Other": return .other
            
        default: return .undefined
        }
    }
}


// MARK: - Displaying Content
private extension ExercisesView {
    
}



// MARK: - Preview

#if DEBUG
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(container: .preview)
            .modifier(RootViewAppearance())
    }
}
#endif
