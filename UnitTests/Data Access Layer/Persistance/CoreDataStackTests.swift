//
//  CoreDataStackTests.swift
//  UnitTests
//
//  Description:
//
//  Created by Dominic Danborn on 3/7/24.
//  Copyright © 2024 Dominic Danborn. All rights reserved.
//

import XCTest
import Combine
@testable import Lift_Tracker

class CoreDataStackTests: XCTestCase {
    
    var systemUnderTest: CoreDataStack!
    
    let testDirectory: FileManager.SearchPathDirectory = .cachesDirectory
    
    var dbVersion: UInt { fatalError("Override") }
    
    var cancelBag = CancelBag()
    
    override func setUp() {
        super.setUp()
        eraseDBFiles()
        systemUnderTest = CoreDataStack(directory: testDirectory, version: dbVersion)
    }
    
    override func tearDown() {
        cancelBag = CancelBag()
        systemUnderTest = nil
        eraseDBFiles()
        super.tearDown()
    }
    
    func eraseDBFiles() {
        let version = CoreDataStack.Version(dbVersion)
        if let url = version.dbFileURL(testDirectory, .userDomainMask) {
            try? FileManager().removeItem(at: url)
        }
    }
    
}

// MARK: - Version 1

final class CoreDataStackV1Tests: CoreDataStackTests {
    
    override var dbVersion: UInt { 1 }
    
    func test_initialization() {
        let expected = XCTestExpectation(description: #function)
        
        let fetchRequest = RoutineMO.newFetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.fetchLimit = 1
        systemUnderTest
            .fetch(fetchRequest) { _ -> Int? in
                return nil
            }
            .sinkToResult { result in
                result.assertSuccess(value: [])
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 1)
    }
    
    func test_inaccessibleDirectory() {
        
        let systemUnderTest = CoreDataStack(directory: .adminApplicationDirectory,
                                            domainMask: .systemDomainMask, version: dbVersion)
        
        let expected = XCTestExpectation(description: #function)
        
        let fetchRequest = RoutineMO.newFetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.fetchLimit = 1
        
        systemUnderTest
            .fetch(fetchRequest) { _ -> Int? in
                return nil
            }
            .sinkToResult { result in
                result.assertFailure()
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 1)
    }
    
    func test_storing_exception() {
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest
            .update { context in
                throw NSError.test
            }
            .sinkToResult { result in
                result.assertFailure(NSError.test.localizedDescription)
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 1)
    }
    
    func test_fetching() {
        let routines = Routine.testData
        
        let expected = XCTestExpectation(description: #function)
        
        systemUnderTest
            .update { context in
                routines.forEach {
                    $0.store(in: context)
                }
            }
            .flatMap { _ -> AnyPublisher<[Routine], Error> in
                let fetchRequest = RoutineMO.newFetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", routines[0].id!.uuidString)
                return self.systemUnderTest.fetch(fetchRequest) {
                    Routine(managedObject: $0)
                }
            }
            .sinkToResult { result in
                result.assertSuccess(value: [routines[0]])
                expected.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [expected], timeout: 1)
    }
}
