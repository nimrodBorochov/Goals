//
//  GoalsView.swift
//  Goals
//
//  Created by Nimrod Borochov on 29/08/2023.
//

import SwiftUI

struct GoalsView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        List(selection: $viewModel.selectedGoal) {
            ForEach(viewModel.dataController.goalsForSelectedFilter()) { goal in
                GoalRow(goal: goal)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Goals")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            suggestedTokens: .constant(viewModel.suggestedFilterTokens),
            prompt: "Filter goals, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: GoalsViewToolbar.init)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalsView(dataController: .preview)
                .environmentObject(DataController.preview)
        }
    }
}
