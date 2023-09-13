//
//  ExtensionTests.swift
//  GoalsTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Goals

final class ExtensionTests: BaseTestCase {
    func testGoalTitleUnwrap() {
        let goal = Goal(context: managedObjectContext)

        goal.title = "Example goal"
        XCTAssertEqual(goal.goalTitle, "Example goal", "Changing title should also change goalTitle.")

        goal.goalTitle = "Updated goal"
        XCTAssertEqual(goal.title, "Updated goal", "Changing goalTitle should also change title.")
    }

    func testGoalContentUnwrap() {
        let goal = Goal(context: managedObjectContext)

        goal.content = "Example content"
        XCTAssertEqual(goal.goalContent, "Example content", "Changing content should also change goalContent.")

        goal.goalContent = "Updated content"
        XCTAssertEqual(goal.content, "Updated content", "Changing goalContent should also change content.")
    }

    func testGoalCreationDateUnwrap() {
        // Given
        let goal = Goal(context: managedObjectContext)
        let testDate = Date.now

        // When
        goal.creationDate = testDate

        // Then
        XCTAssertEqual(goal.goalCreationDate, testDate, "Changing creationDate should also change goalCreationDate.")
    }

    func testGoalTagsUnwrap() {
        let tag = Tag(context: managedObjectContext)
        let goal = Goal(context: managedObjectContext)

        XCTAssertEqual(goal.goalTags.count, 0, "A new goal should have 0 tags.")

        goal.addToTags(tag)
        XCTAssertEqual(goal.goalTags.count, 1, "Adding 1 tag to an goal should result in goalTags having count 1.")
    }

    func testGoalTagsList() {
        let tag = Tag(context: managedObjectContext)
        let goal = Goal(context: managedObjectContext)

        tag.name = "My Tag"
        goal.addToTags(tag)
        print("testGoalTagsList goal.goalTagsList: \(goal.goalTagsList)")

        XCTAssertEqual(goal.goalTagsList, "My Tag", "Adding 1 tag to an goal should make goalTagsList be My Tag.")
    }

    func testGoalSortingIsStable() {
        let goal1 = Goal(context: managedObjectContext)
        goal1.title = "B Goal"
        goal1.creationDate = .now

        let goal2 = Goal(context: managedObjectContext)
        goal2.title = "B Goal"
        goal2.creationDate = .now.addingTimeInterval(1)

        let goal3 = Goal(context: managedObjectContext)
        goal3.title = "A Goal"
        goal3.creationDate = .now.addingTimeInterval(100)

        let allGoals = [goal1, goal2, goal3]
        let sorted = allGoals.sorted()

        XCTAssertEqual([goal3, goal1, goal2], sorted, "Sorting goal arrays should use name then creation date.")
    }

    func testTagIDUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.id = UUID()

        XCTAssertEqual(tag.tagId, tag.id, "Changing id should also change tagId.")
    }

    func testTagNameUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.name = "Example tag"
        XCTAssertEqual(tag.tagName, "Example tag", "Changing name should also change tagName.")
    }

    func testTagActiveGoals() {
        let tag = Tag(context: managedObjectContext)
        let goal = Goal(context: managedObjectContext)

        XCTAssertEqual(tag.tagActiveGoals.count, 0, "A new tag should have 0 active goals.")

        tag.addToGoals(goal)
        XCTAssertEqual(tag.tagActiveGoals.count, 1, "A new tag with 1 new goal should have 1 active goal.")

        goal.completed = true
        XCTAssertEqual(tag.tagActiveGoals.count, 0, "A new tag with 1 completed goal should have 0 active goals.")
    }

    func testTagsSortingIsStable() {
        let tag1 = Tag(context: managedObjectContext)
        tag1.name = "B Tag"
        tag1.id = UUID()

        let tag2 = Tag(context: managedObjectContext)
        tag2.name = "B Tag"
        tag2.id = UUID(uuidString: "FFFFFFFF-DC22-4463-8C69-7275D037C13D")

        let tag3 = Tag(context: managedObjectContext)
        tag3.name = "A Tag"
        tag3.id = UUID()

        let allTags = [tag1, tag2, tag3]
        let sortedTags = allTags.sorted()

        XCTAssertEqual([tag3, tag1, tag2], sortedTags, "Sorting tag arrays should use name then UUID string.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        XCTAssertFalse(awards.isEmpty, "Award.json should decode to a non-empty array.")
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableString.json", as: String.self)
        XCTAssertEqual(data, "If there are no tests, there is no work.", "The string must match DecodableString.json")
    }

    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableDictionary.json", as: [String: Int].self)
        XCTAssertEqual(data.count, 3, "There should be 3 items decode from DecodableString.json")
        XCTAssertEqual(data["one"], 1, "There dictionary should contain the value 1 for the key one.")
    }
}
