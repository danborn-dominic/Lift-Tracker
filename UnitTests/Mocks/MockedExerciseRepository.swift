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
        case createExercise(Exercise)
        case readExercises
        case updateExercise(Exercise)
        case deleteExercise(Exercise)
    }
    
    var actions = MockActions<Action>(expected: [])

    var createExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    var readExercisesResult: Result<[Exercise], Error> = .failure(MockError.valueNotSet)
    var updateExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    var deleteExerciseResult: Result<Void, Error> = .failure(MockError.valueNotSet)

    // MARK: - API
    
    func createExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        register(.createExercise(exercise))
        return createExerciseResult.publish()
    }
    
    func readExercises() -> AnyPublisher<[Exercise], Error> {
        register(.readExercises)
        return readExercisesResult.publish()
    }
    
    func updateExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        register(.updateExercise(exercise))
        return updateExerciseResult.publish()
    }
    
    func deleteExercise(exercise: Exercise) -> AnyPublisher<Void, Error> {
        register(.deleteExercise(exercise))
        return deleteExerciseResult.publish()
    }
}
