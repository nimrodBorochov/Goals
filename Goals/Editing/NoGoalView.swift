//
//  NoGoalView.swift
//  Goals
//
//  Created by nimrod borochov on 31/08/2023.
//

import SwiftUI

struct NoGoalView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Text("No Goal Selected")
            .font(.title)
            .foregroundColor(.secondary)

        Button("New Goal", action: dataController.newGoal)

    }
}

struct NoGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NoGoalView()
            .environmentObject(DataController.preview)
    }
}
