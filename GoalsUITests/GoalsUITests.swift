//
//  GoalsUITests.swift
//  GoalsUITests
//
//  Created by nimrod borochov on 04/09/2023.
//

import XCTest

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Failed to clear text in XCUIElement")
            return
        }

        let deletingString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deletingString)
    }
}

final class GoalsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppStartsWithNavigationBar() throws {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be a navigation bar when the app launches.")
    }

    func testAppHasBasicButtonOnLaunch() {
        XCTAssertTrue(app.navigationBars.buttons["Filters"].exists, "There should be a Filters button on launch.")
        XCTAssertTrue(app.navigationBars.buttons["Filter"].exists, "There should be a Filter button on launch.")
        XCTAssertTrue(app.navigationBars.buttons["New Goal"].exists, "There should be a New Goal  button on launch.")
    }

    func testNoGoalsAtStart() {
        XCTAssertEqual(app.cells.count, 0, "There should be 0 list rows initially.")
    }

    func testCreatingAndDeletingGoals() {
        for tapCount in 1...5 {
            app.buttons["New Goal"].tap()

            // Go back to goals view
            app.buttons["Goals"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }

        for tapCount in (0...4).reversed() {
            app.cells.firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }
    }

    func testEditingGoalTitleUpdatesCorrectly() {
        XCTAssertEqual(app.cells.count, 0, "There should be 0 list rows initially.")

        app.buttons["New Goal"].tap()

        app.textFields["Enter the goal title here"].tap()
        app.textFields["Enter the goal title here"].clear()
        app.typeText("My New Goal")

        app.buttons["Goals"].tap()
        XCTAssertTrue(app.buttons["My New Goal"].exists, "A My New Goal should now exists.")
    }

    func testEditingGoalPriorityShoesIcon() {
        app.buttons["New Goal"].tap()
        app.buttons["Priority, Medium"].tap()
        app.buttons["High"].tap()

        app.buttons["Goals"].tap()

        let identifier = "New goal High Priority"
        XCTAssert(app.images[identifier].exists, "A High-priority goal needs an icon next to it.")
    }

    func testAllAwardsShowLockedAlert() {
        app.buttons["Filters"].tap()
        app.buttons["Show awards"].tap()

        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            if app.windows.element.frame.contains(award.frame) == false {
                app.swipeUp()
            }

            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a Locked alert showing this award.")
            app.buttons["OK"].tap()
        }

    }
}
