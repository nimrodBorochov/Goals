//
//  DevelopmentTests.swift
//  GoalsTests
//
//  Created by Nimrod Borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Goals

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Goal.fetchRequest()), 50, "There should be 50 sample goals.")
    }

    func testDeleteAllClearsEverything () {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "deleteAll() should leave 0 sample tags.")
        XCTAssertEqual(dataController.count(for: Goal.fetchRequest()), 0, "deleteAll() should leave 0 sample goals.")
    }

    func testExampleTagHasNoGoals() {
        let tag = Tag.example

        XCTAssertEqual(tag.goals?.count, 0, "The example tag should have 0 goals.")

    }

    func testExampleGoalHasHighPriority() {
        let goal = Goal.example

        XCTAssertEqual(goal.priority, 2, "The example goal should be high Priority")
    }
}
