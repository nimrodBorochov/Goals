//
//  Goal-CoreDataHelpers.swift
//  Goals
//
//  Created by nimrod borochov on 30/08/2023.
//

import Foundation

extension Goal {
    var goalTitle: String {
        get { title ?? "" }
        set { title = newValue }
    }

    var goalContent: String {
        get { content ?? "" }
        set { content = newValue }
    }

    var goalCreationDate: Date {
        creationDate ?? .now
    }

    var goalModificationDate: Date {
        modificationDate ?? .now
    }

    var goalTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }

    var goalTagsList: String {
        let notTags = NSLocalizedString("No tags", comment: "Goal tags list")

        guard let tags else { return notTags }

        if tags.count == 0 {
            return notTags
        } else {
            return goalTags.map(\.tagName).formatted()
        }
    }

    var goalStatus: String { NSLocalizedString(completed ? "Closed" : "Open", comment: "goal status") }

    var goalFormattedCreationDate: String {
        goalCreationDate.formatted(date: .numeric, time: .omitted)
    }

    static var example: Goal {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let goal = Goal(context: viewContext)
        goal.title = "Example Goal"
        goal.content = "Tis is an example goal."
        goal.priority = 2
        goal.creationDate = .now
        return goal
    }
}

extension Goal: Comparable {
    public static func < (lhs: Goal, rhs: Goal) -> Bool {
        let left = lhs.goalTitle.localizedLowercase
        let right = rhs.goalTitle.localizedLowercase

        if left == right {
            return lhs.goalCreationDate < rhs.goalCreationDate
        } else {
            return left < right
        }
    }
}
