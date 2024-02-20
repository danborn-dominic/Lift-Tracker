//
//  RoutineDetailView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/4/24.
//

import SwiftUI

struct RoutineDetailView: View {
    let workout: WorkoutStruct

    var body: some View {
        List(workout.exercises, id: \.id) { exercise in
            Text(exercise.exerciseName)
        }
        .navigationTitle(workout.workoutName)
    }
}

#if DEBUG
struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineDetailView(workout: WorkoutStruct.mockData[0])
    }
}
#endif
