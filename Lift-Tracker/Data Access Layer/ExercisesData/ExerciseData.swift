//
//  ExercisesLibrary.swift
//  Lift-Tracker
//
//  Created by Dominic Danborn on 3/23/24.
//

import Foundation

struct ExerciseData {
    static var all: [Exercise] {
        return (ChestExercises.data +
                ShoulderExercises.data +
                TricepExercises.data +
                BicepExercises.data +
                QuadsExercises.data +
                HamstringExercises.data +
                CalfExercises.data +
                GluteExercises.data +
                CoreExercises.data +
                ForearmExercises.data +
                BackExercises.data
        )
        .sorted { $0.exerciseName < $1.exerciseName }
    }
}
