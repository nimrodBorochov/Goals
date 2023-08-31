//
//  NoIssueView.swift
//  Issues
//
//  Created by nimrod borochov on 31/08/2023.
//

import SwiftUI

struct NoIssueView: View {
//    @EnvironmentObject var dataController: DataController

    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundColor(.secondary)
        
        Button("New Issue") {
            //TODO: make a new issue
        }
    }
}

struct NoIssueView_Previews: PreviewProvider {
    static var previews: some View {
        NoIssueView()
            .environmentObject(DataController.preview)
    }
}
