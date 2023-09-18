//
//  TagsMenuView.swift
//  Goals
//
//  Created by Nimrod Borochov on 01/09/2023.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var goal: Goal

    var body: some View {
        Menu {
            selectedTags

            // unselected tags
            let otherTags = dataController.missingTags(from: goal)
            if otherTags.isEmpty == false {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button(tag.tagName) {
                            goal.addToTags(tag)
                        }
                    }
                }
            }
        } label: {
            Text(goal.goalTagsList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(nil, value: goal.goalTagsList)
        }
    }

    private var selectedTags: some View {
        ForEach(goal.goalTags) { tag in
            Button {
                goal.removeFromTags(tag)
            } label: {
                Label(tag.tagName, systemImage: "checkmark")
            }
        }
    }
}

struct TagsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TagsMenuView(goal: .example)
            .environmentObject(DataController.preview)
    }
}
