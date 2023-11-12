//
//  GoalRow.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import SwiftUI

struct GoalRow: View {
    @EnvironmentObject var dataController: DataController
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationLink(value: viewModel.goal) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(viewModel.iconOpacity)
                    .accessibilityIdentifier(viewModel.iconIdentifier)

                VStack(alignment: .leading) {
                    Text(viewModel.goalTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(viewModel.goalTagsList)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewModel.creationDate)
                        .accessibilityLabel(viewModel.accessibilityCreationDate)
                        .font(.subheadline)

                    if viewModel.completed {
                        Text("CLOSED")
                            .font(.body.smallCaps())
                    }
                }
                .foregroundColor(.secondary)
            }
        }
        .accessibilityHint(viewModel.accessibilityHint)
        .accessibilityIdentifier(viewModel.goalTitle)
    }

    init(goal: Goal) {
        let viewModel = ViewModel(goal: goal)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct GoalRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalRow(goal: .example)
    }
}
