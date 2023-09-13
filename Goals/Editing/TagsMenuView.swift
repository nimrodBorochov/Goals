//
//  TagsMenuView.swift
//  Goals
//
//  Created by nimrod borochov on 01/09/2023.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var goal: Goal

    var body: some View {
        Menu {
            // selected tags
            ForEach(goal.goalTags) { tag in
                Button {
                    goal.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }

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
}

struct TagsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TagsMenuView(goal: .example)
            .environmentObject(DataController.preview)
    }
}
