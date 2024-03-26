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
    
    private let container: DIContainer
    
    @State private(set) var exercises: Loadable<[Exercise]> = .notRequested

    @State private var exerciseData: [Exercise] = ExerciseData.all
    
    @State private var selectedBodyPart: MuscleGroup = .undefined
    @State private var selectedCategory: ExerciseType = .undefined
    
    @State private var isShowingBodyPartPicker: Bool = false
    @State private var isShowingCategoryPicker: Bool = false
    
    @State private var selectedBodyPartFilter: String = "Body Part"
    @State private var selectedCategoryFilter: String = "Category"
    
    @State private var searchQuery: String = ""
    
    
    let bodyParts: [String] = MuscleGroup.allDisplayNames
    let categories: [String] = ExerciseType.allDisplayNames
    
    
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
        switch exercises {
        case .notRequested:
            notRequestedView
        case .isLoading(let last, let cancelBag):
            loadingView
        case .loaded:
            loadedView()
        case .failed(let error):
            failedView(error)
        }
    }
}

// MARK: - Routing
extension ExercisesView {
    struct Routing: Equatable {
        var exerciseDetails: Exercise.ID?
    }
}

// MARK: - Managing Content
private extension ExercisesView {
    
    func loadExercises() {
        print("called loadExercises")
    }
    
    private func filteredExercises() -> [Exercise] {
        let selectedMuscleGroup = muscleGroup(for: selectedBodyPartFilter)
        let selectedExType = exerciseType(for: selectedCategoryFilter)
        
        return exerciseData.filter { exercise in
            let matchesSearchQuery = searchQuery.isEmpty || exercise.exerciseName.localizedCaseInsensitiveContains(searchQuery)
            let matchesMuscleGroup = selectedMuscleGroup == .undefined || exercise.muscleGroup == selectedMuscleGroup
            let matchesExerciseType = selectedExType == .undefined || exercise.exerciseType == selectedExType
            
            return matchesSearchQuery && matchesMuscleGroup && matchesExerciseType
        }
    }
    
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


// MARK: - Loading Content

private extension ExercisesView {
    var notRequestedView: some View {
        Text("")
            .foregroundColor(Color.secondaryTextColor)
            .onAppear(perform: loadExercises)
    }
    
    var loadingView: some View {
        Text("Loading...")
            .foregroundColor(Color.secondaryTextColor)
    }
    
    func failedView(_ error: Error) -> some View {
        Text("Failed to load exercises: \(error.localizedDescription)")
            .foregroundColor(Color.secondaryTextColor)
            .onTapGesture { self.loadExercises() }
    }
}

// MARK: - Displaying Content
private extension ExercisesView {
    
    func loadedView() -> some View {
        
        Group {
            VStack(spacing: 10) {
                searchBar
                    .padding(.horizontal)
                filters
                    .padding(.horizontal)
                exercisesView
            }
            .padding(.top, 100)
            
            if isShowingBodyPartPicker {
                bodyPartPickerOverlay
            }
            if isShowingCategoryPicker {
                categoryPickerOverlay
            }
        }
    }
    
    var searchBar: some View {
        ZStack {
            Rectangle()
                .fill(Color.componentColor)
                .frame(width: 356, height: 34)
                .cornerRadius(8)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.secondaryTextColor)
                ZStack(alignment: .leading) {
                    if searchQuery.isEmpty {
                        Text("Search")
                            .foregroundColor(Color.secondaryTextColor)
                    }
                    TextField("", text: $searchQuery)
                        .foregroundColor(Color.secondaryTextColor)
                }
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
    
    var filters: some View {
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
    
    var exercisesView: some View {
        VStack {
            HStack {
                Text("All Exercises")
                    .foregroundColor(Color.secondaryTextColor)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 0))
                Spacer()
            }
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(filteredExercises()) { exercise in
                        ExerciseCardView(
                            exerciseName: exercise.exerciseName,
                            bodyPart: exercise.muscleGroup.displayName,
                            equipment: exercise.exerciseType.displayName,
                            weight: "\(exercise.maxWeight) lbs",
                            reps: "\(exercise.repsForMaxWeight) reps",
                            performed: exercise.isPerformed
                        )
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 12))
            }
            .padding(.bottom, 90)
        }
    }
    
    var bodyPartPickerOverlay: some View {
        ZStack {
            Color.backgroundColor
                .opacity(0.8)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isShowingBodyPartPicker = false
                }
            BodyPartPickerOverlay(
                isPresented: $isShowingBodyPartPicker,
                selectedBodyPart: Binding<String>(
                    get: { self.selectedBodyPartFilter },
                    set: { newValue in
                        self.selectedBodyPartFilter = newValue == "Any" ? "Body Part" : newValue
                    }
                ),
                bodyParts: bodyParts
            )
        }
    }
    
    var categoryPickerOverlay: some View {
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

// MARK: - Preview

#if DEBUG
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(container: .preview)
            .modifier(RootViewAppearance())
    }
}
#endif
