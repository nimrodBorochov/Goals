//
//  GoalViewToolbar.swift
//  Goals
//
//  Created by nimrod borochov on 01/09/2023.
//

import SwiftUI

struct GoalViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var goal: Goal

    var openCloseButtonText: LocalizedStringKey {
        goal.completed ? "Re-open Goal" : "Close Goal"
    }

    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = goal.title
            } label: {
                Label("Copy Goal Title", systemImage: "doc.on.doc")
            }

            Button {
                goal.completed.toggle()
                dataController.save()
            } label: {
                Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }

            Divider()

            Section("Tags") {
                TagsMenuView(goal: goal)
            }

        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
}

struct GoalViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        GoalViewToolbar(goal: Goal.example)
            .environmentObject(DataController(inMemory: true))
    }
}
