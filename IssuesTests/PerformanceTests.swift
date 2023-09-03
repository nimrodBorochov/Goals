//
//  PerformanceTests.swift
//  IssuesTests
//
//  Created by nimrod borochov on 03/09/2023.
//

import XCTest
@testable import Issues

final class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards  = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the award count is constant. Change this when add award")
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
