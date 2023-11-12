//
//  GoalsViewModel.swift
//  Goals
//
//  Created by Nimrod Borochov on 18/10/2023.
//

import Foundation

extension GoalsView {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var dataController: DataController

        init(dataController: DataController) {
            self.dataController = dataController
        }

        subscript<Value>(dynamicMember keyPath: KeyPath<DataController, Value>) -> Value {
            dataController[keyPath: keyPath]
        }

        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<DataController, Value>) -> Value {
            get { dataController[keyPath: keyPath] }
            set { dataController[keyPath: keyPath] = newValue }
        }

        func delete (_ offsets: IndexSet) {
            let goals = dataController.goalsForSelectedFilter()

            for offset in offsets {
                let item = goals[offset]
                dataController.delete(item)
            }
        }
    }
}
