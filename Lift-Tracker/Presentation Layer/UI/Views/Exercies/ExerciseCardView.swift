//
//  ExerciseCardView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/23/24.
//

import SwiftUI

struct ExerciseCardView: View {
    let exerciseName: String
    let bodyPart: String
    let equipment: String
    let weight: String
    let reps: String
    let performed: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                
                Text(exerciseName)
                    .font(.headline)
                    .foregroundColor(Color.primaryTextColor)
                HStack {
                    Text(bodyPart)
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryTextColor)
                    Text(equipment)
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryTextColor)
                    Spacer()
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                if performed {
                    Text(weight)
                        .font(.headline)
                        .foregroundColor(Color.primaryTextColor)
                    Text(reps)
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryTextColor)
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        .background(Color.componentColor)
        .cornerRadius(10)
    }
}

#Preview {
    VStack(spacing: 6) {
        ExerciseCardView(exerciseName: "Barbell Back Squat", bodyPart: "Quads", equipment: "Barbell", weight: "0 lbs", reps: "0 reps", performed: false).padding(.horizontal, 4)
        ExerciseCardView(exerciseName: "Romanian Deadlifts", bodyPart: "Hamstrings", equipment: "Barbell", weight: "245 lbs", reps: "10 reps", performed: true).padding(.horizontal, 4)
    }
}
