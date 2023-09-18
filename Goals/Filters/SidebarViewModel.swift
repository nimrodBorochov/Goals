//
//  SidebarViewModel.swift
//  Goals
//
//  Created by Nimrod Borochov on 07/09/2023.
//

import CoreData
import Foundation

extension SidebarView { // allows to use the name ViewModel freely, because it’s nested
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var dataController: DataController

// @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag> // works on view for now :)
        private let tagController: NSFetchedResultsController<Tag>
        @Published var tags = [Tag]()

        @Published var tagToRename: Tag?
        @Published var renamingTag = false
        @Published var tagName = ""

        var tagFilters: [Filter] {
            tags.map { tag in
                Filter(id: tag.tagId, name: tag.tagName, icon: "tag", tag: tag)
            }
        }

        init(dataController: DataController) {
            self.dataController = dataController

            let request = Tag.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]

            tagController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()
            tagController.delegate = self

            do {
                try tagController.performFetch()
                tags = tagController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch tags")
            }
        }

        func delete(_ offsets: IndexSet) {
            for offset in offsets {
                let item = tags[offset]
                dataController.delete(item)
            }
        }

        func delete(_ filter: Filter) {
            guard let tag = filter.tag else { return }
            dataController.delete(tag)
            dataController.save()
        }

        func rename(_ filter: Filter) {
            tagToRename = filter.tag
            tagName = filter.name
            renamingTag = true
        }

        func completeRename() {
            tagToRename?.name = tagName
            dataController.save()
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newTags = controller.fetchedObjects as? [Tag] {
                tags = newTags
            }
        }
    }
}
