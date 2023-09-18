//
//  ContentView.swift
//  Goals
//
//  Created by Nimrod Borochov on 29/08/2023.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        List(selection: $dataController.selectedGoal) {
            ForEach(dataController.goalsForSelectedFilter()) { goal in
                GoalRow(goal: goal)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Goals")
        .searchable(
            text: $dataController.filterText,
            tokens: $dataController.filterTokens,
            suggestedTokens: .constant(dataController.suggestedFilterTokens),
            prompt: "Filter goals, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: GoalsViewToolbar.init)
    }

    func delete (_ offsets: IndexSet) {
        let goals = dataController.goalsForSelectedFilter()

        for offset in offsets {
            let item = goals[offset]
            dataController.delete(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalsView()
                .environmentObject(DataController.preview)
        }
    }
}
