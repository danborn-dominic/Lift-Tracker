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
    
    let routine: RoutineStruct
    
    var body: some View {
        List(routine.exercises, id: \.id) { exercise in
            Text(exercise.exerciseName)
        }
        .navigationTitle(routine.routineName)
    }
}
