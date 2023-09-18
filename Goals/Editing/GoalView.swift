//
//  GoalView.swift
//  Goals
//
//  Created by Nimrod Borochov on 31/08/2023.
//

import SwiftUI

struct GoalView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var goal: Goal

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    titleTextField

                    modifiedText
                        .foregroundColor(.secondary)

                    Text("**Status:** \(goal.goalStatus)")
                        .foregroundColor(.secondary)
                }

                priorityPicker

                TagsMenuView(goal: goal)
            }

            basicInformationSection
        }
        .disabled(goal.isDeleted)
        .onReceive(goal.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar { GoalViewToolbar(goal: goal ) }
    }

    private var titleTextField: some View {
        TextField("Title", text: $goal.goalTitle, prompt: Text("Enter the goal title here"))
            .font(.title)
    }

    private var modifiedText: some View {
        Text("**Modified:** \(goal.goalModificationDate.formatted(date: .long, time: .shortened))")
    }

    private var priorityPicker: some View {
        Picker("Priority", selection: $goal.priority) {
            Text("Low").tag(Int16(0))
            Text("Medium").tag(Int16(1))
            Text("High").tag(Int16(2))
        }
    }

    private var basicInformationSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Basic Information")
                    .font(.title2)
                    .foregroundColor(.secondary)

                descriptionTextField
            }
        }
    }

    private var descriptionTextField: some View {
        TextField(
            "Description",
            text: $goal.goalContent,
            prompt: Text("Enter the goal description here"),
            axis: .vertical
        )
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalView(goal: .example)
                .environmentObject(DataController.preview)
        }
    }
}
