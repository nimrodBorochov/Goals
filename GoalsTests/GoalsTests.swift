//
//  GoalsTests.swift
//  GoalsTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Goals

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
