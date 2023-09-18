//
//  UserFilterRow.swift
//  Goals
//
//  Created by Nimrod Borochov on 02/09/2023.
//

import SwiftUI

struct UserFilterRow: View {
    var filter: Filter
    var rename: (Filter) -> Void
    var delete: (Filter) -> Void

    var body: some View {
        NavigationLink(value: filter) {
            Label(filter.name, systemImage: filter.icon)
                .badge(filter.activeGoalsCount)
                .contextMenu {
                    renameButton
                    deleteBotton
                }
                .accessibilityElement()
                .accessibilityLabel(filter.name)
                .accessibilityHint("\(filter.activeGoalsCount) goals")
        }
    }

    private var renameButton: some View {
        Button {
            rename(filter)
        } label: {
            Label("Rename", systemImage: "pencil")
        }
    }

    private var deleteBotton: some View {
        Button(role: .destructive) {
            delete(filter)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

struct UserFilterRow_Previews: PreviewProvider {
    static var previews: some View {
        UserFilterRow(filter: .all, rename: { _ in }, delete: { _ in })
    }
}
