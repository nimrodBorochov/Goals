//
//  GoalRowViewModel.swift
//  Goals
//
//  Created by Nimrod Borochov on 18/10/2023.
//

import Foundation

extension GoalRow {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var goal: Goal

        var iconOpacity: Double {
            goal.priority == 2 ? 1 : 0
        }

        var iconIdentifier: String {
            goal.priority == 2 ? "\(goal.goalTitle) High Priority" : ""
        }

        var accessibilityHint: String {
            goal.priority == 2 ? "High priority " : ""
        }

        var accessibilityCreationDate: String {
            goal.goalCreationDate.formatted(date: .abbreviated, time: .omitted)
        }
        var creationDate: String {
            goal.goalCreationDate.formatted(date: .numeric, time: .omitted)
        }

        init(goal: Goal) {
            self.goal = goal
        }

        subscript<Value>(dynamicMember keyPath: KeyPath<Goal, Value>) -> Value {
            goal[keyPath: keyPath]
        }
    }
}
