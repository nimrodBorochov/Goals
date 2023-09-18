//
//  GoalViewToolbar.swift
//  Goals
//
//  Created by Nimrod Borochov on 01/09/2023.
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
            copyGoalTitleButton
            openCloseButton

            Divider()

            Section("Tags") {
                TagsMenuView(goal: goal)
            }

        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }

    private var copyGoalTitleButton: some View {
        Button {
            UIPasteboard.general.string = goal.title
        } label: {
            Label("Copy Goal Title", systemImage: "doc.on.doc")
        }
    }

    private var openCloseButton: some View {
        Button {
            goal.completed.toggle()
            dataController.save()
        } label: {
            Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
        }
    }
}

struct GoalViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        GoalViewToolbar(goal: Goal.example)
            .environmentObject(DataController(inMemory: true))
    }
}
