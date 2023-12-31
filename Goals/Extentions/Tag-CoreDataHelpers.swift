//
//  Tag-CoreDataHelpers.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import Foundation

extension Tag {
    var tagId: UUID {
        id ?? UUID()
    }

    var tagName: String {
        name ?? ""
    }

    var tagActiveGoals: [Goal] {
        let result = goals?.allObjects as? [Goal] ?? []
        return result.filter { $0.completed == false }
    }

    static var example: Tag {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let tag = Tag(context: viewContext)
        tag.id = UUID()
        tag.name = "Example Tag"
        return tag
    }
}

extension Tag: Comparable {
    public static func < (lhs: Tag, rhs: Tag) -> Bool {
        let left = lhs.tagName.localizedLowercase
        let right = rhs.tagName.localizedLowercase

        if left == right {
            return lhs.tagId.uuidString < rhs.tagId.uuidString
        } else {
            return left < right
        }
    }
}
