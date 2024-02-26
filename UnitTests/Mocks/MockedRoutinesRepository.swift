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

final class MockedRoutinesRepository: Mock, RoutinesRepository {
    
    enum Action: Equatable {
        case createRoutine(RoutineStruct)
        case readRoutines
        case updateRoutine(RoutineStruct)
        case deleteRoutine(RoutineStruct)
    }

    var actions = MockActions<Action>(expected: [])
    
    func createRoutine(routine: Lift_Tracker.RoutineStruct) -> AnyPublisher<Void, Error> {
        <#code#>
    }
    
    func readRoutines() -> AnyPublisher<[Lift_Tracker.RoutineStruct], Error> {
        <#code#>
    }
    
    func updateRoutine(routine: Lift_Tracker.RoutineStruct) -> AnyPublisher<Void, Error> {
        <#code#>
    }
    
    func deleteRoutine(routine: Lift_Tracker.RoutineStruct) -> AnyPublisher<Void, Error> {
        <#code#>
    }
}
