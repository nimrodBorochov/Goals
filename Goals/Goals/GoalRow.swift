//
//  GoalRow.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import SwiftUI

struct GoalRow: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var goal: Goal

    var body: some View {
        NavigationLink(value: goal) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(goal.priority == 2 ? 1 : 0)
                    .accessibilityIdentifier(goal.priority == 2 ? "\(goal.goalTitle) High Priority" : "")

                VStack(alignment: .leading) {
                    Text(goal.goalTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(goal.goalTagsList)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(goal.goalFormattedCreationDate)
                        .accessibilityLabel(goal.goalCreationDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)

                    if goal.completed {
                        Text("CLOSED")
                            .font(.body.smallCaps())
                    }
                }
                .foregroundColor(.secondary)
            }
        }
        .accessibilityHint(goal.priority == 2 ? "High priority " : "")
        .accessibilityIdentifier(goal.goalTitle)
    }
}

struct GoalRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalRow(goal: .example)
    }
}
