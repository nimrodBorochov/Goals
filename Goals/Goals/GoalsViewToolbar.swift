//
//  GoalsViewToolbar.swift
//  Goals
//
//  Created by Nimrod Borochov on 01/09/2023.
//

import SwiftUI

struct GoalsViewToolbar: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Menu {
            onOffFilterButton
            Divider()
            sortByMenu

            Group {
                statusPicker
                priorityPicker
            }
            .disabled(dataController.filterEnabled == false)
        } label: {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                .symbolVariant(dataController.filterEnabled ? .fill : .none )
        }
        newGoalButton
    }

    private var onOffFilterButton: some View {
        Button(dataController.filterEnabled ? "Turn Filter Off" : "Turn Filter On") {
            dataController.filterEnabled.toggle()
        }
    }

    private var sortByMenu: some View {
        Menu("Sort By") {
            sortByPicker
            Divider()
            sortOrderPicker
        }
    }

    private var sortByPicker: some View {
        Picker("Sort By", selection: $dataController.sortType) {
            Text("Date Created").tag(SortType.dateCreated)
            Text("Date Modified").tag(SortType.dateModified)
        }
    }

    private var sortOrderPicker: some View {
        Picker("Sort Order", selection: $dataController.sortNewestFirst) {
            Text("Newest to Oldest").tag(true)
            Text("Oldest to Newest").tag(false)
        }
    }

    private var statusPicker: some View {
        Picker("Status", selection: $dataController.filterStatus) {
            Text("All").tag(Status.all)
            Text("Open").tag(Status.open)
            Text("Closed").tag(Status.closed)
        }
    }

    private var priorityPicker: some View {
        Picker("Priority", selection: $dataController.filterPriority) {
            Text("All").tag(-1)
            Text("Low").tag(0)
            Text("Medium").tag(1)
            Text("High").tag(2)
        }
    }

    private var newGoalButton: some View {
        Button(action: dataController.newGoal) {
            Label("New Goal", systemImage: "square.and.pencil")
        }
    }
}

struct ContentViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        GoalsViewToolbar()
            .environmentObject(DataController.preview)
    }
}
