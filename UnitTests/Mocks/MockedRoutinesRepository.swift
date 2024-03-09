//
//  MockedRoutinesRepository.swift
//  UnitTests
//
//  Description:
//  This file defines the `RoutinesRepository` protocol and its concrete implementation `RealRoutinesRepository`.
//  The repository acts as an intermediary between the persistence layer (Core Data) and the application logic,
//  facilitating CRUD operations for routines. It abstracts the underlying data fetching and manipulation
//  mechanisms, providing a clean interface for interacting with routine data.
//  This includes creating, reading, updating, and deleting routines, using Core Data and Combine for asynchronous operations.
//
//  Created by Dominic Danborn on 2/26/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import Combine
@testable import Lift_Tracker

/// A mock implementation of `RoutinesRepository` for unit testing purposes.
/// This class allows to simulate various scenarios by setting predefined results for CRUD operations.
final class MockedRoutinesRepository: Mock, RoutinesRepository {
    
    /// Enumeration of actions that can be performed on the repository.
    /// This aids in tracking which actions were invoked during tests.
    enum Action: Equatable {
        case createRoutine(RoutineStruct)
        case readRoutines
        case updateRoutine(RoutineStruct)
        case deleteRoutine(RoutineStruct)
    }
    
    /// A record of actions performed on the mock for verification in tests.
    var actions = MockActions<Action>(expected: [])
    
    /// Predefined results for creating a routine, initially set to a failure state.
    var createRoutineResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    /// Predefined results for reading routines, initially set to a failure state.
    var readRoutinesResult: Result<[RoutineStruct], Error> = .failure(MockError.valueNotSet)
    /// Predefined results for updating a routine, initially set to a failure state.
    var updateRoutineResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    /// Predefined results for deleting a routine, initially set to a failure state.
    var deleteRoutineResult: Result<Void, Error> = .failure(MockError.valueNotSet)
    
    // MARK: - API
    
    /// Simulates the creation of a routine.
    /// Registers the action and returns a predefined result.
    /// - Parameter routine: The routine to create.
    /// - Returns: A publisher emitting the result of the operation.
    func createRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        register(.createRoutine(routine))
        return createRoutineResult.publish()
    }
    
    /// Simulates reading routines.
    /// Registers the action and returns a predefined result.
    /// - Returns: A publisher emitting an array of routines or an error.
    func readRoutines() -> AnyPublisher<[RoutineStruct], Error> {
        register(.readRoutines)
        return readRoutinesResult.publish()
    }
    
    /// Simulates updating a routine.
    /// Registers the action and returns a predefined result.
    /// - Parameter routine: The routine to update.
    /// - Returns: A publisher emitting the result of the operation.
    func updateRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        register(.updateRoutine(routine))
        return updateRoutineResult.publish()
    }
    
    /// Simulates deleting a routine.
    /// Registers the action and returns a predefined result.
    /// - Parameter routine: The routine to delete.
    /// - Returns: A publisher emitting the result of the operation.
    func deleteRoutine(routine: RoutineStruct) -> AnyPublisher<Void, Error> {
        register(.deleteRoutine(routine))
        return deleteRoutineResult.publish()
    }
}
