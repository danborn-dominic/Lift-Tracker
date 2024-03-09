//
//  MockedExerciseRepository.swift
//  UnitTests
//
//  Description:
//
//  Created by Dominic Danborn on 3/8/24.

//

import XCTest
import Combine
@testable import Lift_Tracker

final class MockedExerciseLibraryRepository: Mock, ExerciseLibraryRepository {
    
    enum Action: Equatable {
        case createExercise(ExerciseStruct)
        case readExercises
        case updateExercise(ExerciseStruct)
        case deleteExercise(ExerciseStruct)
    }
    
    var actions = MockActions<Action>(expected: [])

    var createExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    var readExercisesResult: Result<[ExerciseStruct], Error> = .failure(MockError.valueNotSet)
    var updateExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    var deleteExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)

    // MARK: - API
    
    func createExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        register(.createExercise(exercise))
        return createExerciseResult.publish()
    }
    
    func readExercises() -> AnyPublisher<[ExerciseStruct], Error> {
        register(.readExercises)
        return readExercisesResult.publish()
    }
    
    func updateExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        register(.updateExercise(exercise))
        return updateExerciseResult.publish()
    }
    
    func deleteExercise(exercise: ExerciseStruct) -> AnyPublisher<Void, Error> {
        register(.deleteExercise(exercise))
        return deleteExerciseResult.publish()
    }
}
