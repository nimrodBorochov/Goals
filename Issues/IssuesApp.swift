//
//  IssuesApp.swift
//  Issues
//
//  Created by nimrod borochov on 29/08/2023.
//

import SwiftUI

@main
struct IssuesApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
