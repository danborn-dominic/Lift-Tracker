//
//  RoutineDetailView.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 2/4/24.
//
//  Description:
// TODO: write description
//
//  Copyright © 2023 Dominic Danborn. All rights reserved.
//

import SwiftUI

struct RoutineDetailView: View {
    
    let workout: RoutineStruct
    
    var body: some View {
        List(workout.exercises, id: \.id) { exercise in
            Text(exercise.exerciseName)
        }
        .navigationTitle(workout.routineName)
    }
}

#if DEBUG
struct RoutineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineDetailView(workout: RoutineStruct.mockData[0])
    }
}
#endif
