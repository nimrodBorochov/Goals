//
//  SidebarViewToolbar.swift
//  Goals
//
//  Created by Nimrod Borochov on 01/09/2023.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State var showingAwards: Bool = false

    var body: some View {
        addTagButton
        showAwardsButton
            .sheet(isPresented: $showingAwards, content: AwardsView.init)

        #if DEBUG
        addSamplesButton
        #endif
    }

    private var addTagButton: some View {
        Button(action: dataController.newTag) {
            Label("Add tag", systemImage: "plus")
        }
    }

    private var showAwardsButton: some View {
        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }
    }

    #if DEBUG
    private var addSamplesButton: some View {
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("ADD SAMPLES", systemImage: "flame")
        }
    }
    #endif

    }

    struct SidebarViewToolbar_Previews: PreviewProvider {
        static var previews: some View {
            SidebarViewToolbar()
                .environmentObject(DataController.preview)

        }
    }
