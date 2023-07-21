//
//  WorkoutDetailView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 5/27/23.
//

import Foundation
import SwiftUI
import Combine

extension NumberFormatter {
    static var workoutWeightFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

struct WorkoutDetailView: View {
    let workout: WorkoutStruct

    var body: some View {
        List {
            ForEach(workout.exercises, id: \.id) { exercise in
                Section(header: Text(exercise.name).font(.title)) {
                    ForEach(exercise.sets, id: \.id) { set in
                        HStack {
                            Text("Set")
                            Spacer()
                            Text("\(set.repetitions) reps at \(NumberFormatter.workoutWeightFormatter.string(from: NSNumber(value: set.weight)) ?? "") lbs")
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(workout.name), displayMode: .inline)
    }
}


// MARK: - Preview

#if DEBUG
    struct WorkoutDetails_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutDetailView(workout: WorkoutStruct.mockedData[0])
                .inject(.preview)
        }
    }
#endif
