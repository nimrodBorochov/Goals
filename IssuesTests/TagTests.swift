//
//  TagTests.swift
//  IssuesTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Issues

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let targetCount = 10
        let issueCount = targetCount * targetCount

        for _ in 0..<targetCount {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<targetCount {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), targetCount, "Expected \(targetCount) tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), issueCount, "Expected \(issueCount) issues.")
    }

    func testDeletingTagDoesNotDeleteIssue() throws {
        // create 5 tags, each connected to 10 issues
        dataController.createSampleData()

        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "Expected 4 tags after deleting 1.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "Expected 50 issues after deleting a tag.")
    }
}
