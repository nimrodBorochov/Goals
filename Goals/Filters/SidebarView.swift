//
//  SidebarView.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import SwiftUI

struct SidebarView: View {
    @StateObject private var viewModel: ViewModel

    let smartFilters: [Filter] = [.all, .recent]

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.dataController.selectedFilter) {
            smartFiltersSection
            tagsSection
        }
        .toolbar(content: SidebarViewToolbar.init)
        .alert("Rename tag", isPresented: $viewModel.renamingTag) {
            Button("OK", action: viewModel.completeRename)
            Button("Cancel", role: .cancel) { }
            TextField("New tag", text: $viewModel.tagName)
        }
        .navigationTitle("Filters")
    }

    private var smartFiltersSection: some View {
        Section("Smart Filters") {
            ForEach(smartFilters, content: SmartFilterRow.init)
        }
    }

    private var tagsSection: some View {
        Section("Tags") {
            ForEach(viewModel.tagFilters) { filter in
                UserFilterRow(filter: filter, rename: viewModel.rename, delete: viewModel.delete)
            }
            .onDelete(perform: viewModel.delete)
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(dataController: DataController.preview)
    }
}
