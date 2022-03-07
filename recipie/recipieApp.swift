//
//  recipieApp.swift
//  recipie
//
//  Created by Pedro Lenzi on 07/03/22.
//

import SwiftUI

@main
struct recipieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
