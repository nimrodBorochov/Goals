//
//  AwardsTest.swift
//  GoalsTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import CoreData
import XCTest
@testable import Goals

final class AwardsTests: BaseTestCase {
    let awards = Award.allAwards

    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }

    func testNewUserHasUnlockedNoAwards() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have no earned awards.")
        }
    }

    func testCreatingGoalsUnlocksAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var goals = [Goal]()

            for _ in 0..<value {
                let goal = Goal(context: managedObjectContext)
                goals.append(goal)
            }

            let matches = awards.filter { award in
                award.criterion == "goals" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Adding \(value) goals should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }

    func testClosingGoalsUnlocksAwards() {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (count, value) in values.enumerated() {
            var goals = [Goal]()

            for _ in 0..<value {
                let goal = Goal(context: managedObjectContext)
                goal.completed = true
                goals.append(goal)
            }

            let matches = awards.filter { award in
                award.criterion == "closed" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, count + 1, "Completing \(value) goals should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }
}
