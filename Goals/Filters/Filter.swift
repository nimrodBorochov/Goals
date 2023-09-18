//
//  Filter.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var tag: Tag?

    var activeGoalsCount: Int {
        tag?.tagActiveGoals.count ?? 0
    }

    static var all = Filter(
        id: UUID(),
        name: "All Goals",
        icon: "tray"
    )

    static var recent = Filter(
        id: UUID(),
        name: "Recent Goals",
        icon: "clock",
        minModificationDate: .now.addingTimeInterval(86400 * -7)
    )

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
