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
                Text(weight)
                    .font(.headline)
                    .foregroundColor(Color.primaryTextColor)
                Text(reps)
                    .font(.subheadline)
                    .foregroundColor(Color.secondaryTextColor)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        .background(Color.componentColor)
        .cornerRadius(10)
    }
}

#Preview {
    ExerciseCardView(exerciseName: "Barbell Back Squat", bodyPart: "Quads", equipment: "Barbell", weight: "245", reps: "10").padding(.horizontal, 4)
}
