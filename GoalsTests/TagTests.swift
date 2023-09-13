//
//  TagTests.swift
//  GoalsTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Goals

final class TagTests: BaseTestCase {
    func testCreatingTagsAndGoals() {
        let targetCount = 10
        let goalCount = targetCount * targetCount

        for _ in 0..<targetCount {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<targetCount {
                let goal = Goal(context: managedObjectContext)
                tag.addToGoals(goal)
            }
        }

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), targetCount, "Expected \(targetCount) tags.")
        XCTAssertEqual(dataController.count(for: Goal.fetchRequest()), goalCount, "Expected \(goalCount) goals.")
    }

    func testDeletingTagDoesNotDeleteGoal() throws {
        // create 5 tags, each connected to 10 goals
        dataController.createSampleData()

        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "Expected 4 tags after deleting 1.")
        XCTAssertEqual(dataController.count(for: Goal.fetchRequest()), 50, "Expected 50 goals after deleting a tag.")
    }
}
