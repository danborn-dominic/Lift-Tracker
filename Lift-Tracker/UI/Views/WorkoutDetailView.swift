//
//  WorkoutDetailView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/27/23.
//

import Foundation
import SwiftUI
import Combine

struct WorkoutDetailView: View {
    let workout: WorkoutStruct

    var body: some View {
        Text("hi")
        let print = print("INFO viewing workout: ", workout)
        List {
            ForEach(workout.exercises, id: \.id) { exercise in
                Section(header: Text(exercise.name).font(.title)) {
                    ForEach(exercise.sets, id: \.id) { set in
                        HStack {
                            Text("Set")
                            Spacer()
                            Text("\(set.repetitions) reps at \(set.weight) lbs")
                        }
                    }
                }
            }
        }
            .navigationBarTitle(Text(workout.name), displayMode: .inline)
    }
}
