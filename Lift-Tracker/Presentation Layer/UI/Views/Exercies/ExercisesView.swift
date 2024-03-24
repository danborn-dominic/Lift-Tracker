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
    
    @State private var exerciseData: [Exercise] = Exercise.testData
    
    private let container: DIContainer
    
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
                Rectangle()
                    .fill(Color.componentColor)
                    .frame(width: 114, height: 24)
                    .cornerRadius(8)
                Text("Body Part")
                    .foregroundColor(Color.secondaryTextColor)
                    .font(.system(size: 12))
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.componentColor)
                    .frame(width: 114, height: 24)
                    .cornerRadius(8)
                Text("Category")
                    .foregroundColor(Color.secondaryTextColor)
                    .font(.system(size: 12))
            }
            
            ZStack {
                Rectangle()
                    .fill(Color.componentColor)
                    .frame(width: 114, height: 24)
                    .cornerRadius(8)
                Text("Recent")
                    .foregroundColor(Color.secondaryTextColor)
                    .font(.system(size: 12))
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
                    ForEach(exerciseData) { exercise in
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
