//
//  DetailView.swift
//  Goals
//
//  Created by Nimrod Borochov on 30/08/2023.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        VStack {
            if let goal = dataController.selectedGoal {
                GoalView(goal: goal)
            } else {
                NoGoalView()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView()
                .environmentObject(DataController.preview)
        }
    }
}
