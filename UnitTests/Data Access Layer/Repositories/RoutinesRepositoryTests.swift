//
//  RoutinesRepositoryTests.swift
//  UnitTests
//
//  Description:
//
//  Created by Dominic Danborn on 3/1/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import Combine
@testable import Lift_Tracker

class RoutinesRepositoryTests: XCTestCase {
    
    var systemUnderTest: RealRoutinesRepository!
    
    var mockedStore: MockedPersistentStore!
    
    var cancelBag = CancelBag()

    override func setUp() {
        mockedStore = MockedPersistentStore()
        systemUnderTest = RealRoutinesRepository(persistentStore: mockedStore)
        mockedStore.verify()
    }
    
    override func tearDown() {
        cancelBag = CancelBag()
        systemUnderTest = nil
        mockedStore = nil
    }
    
    
}
