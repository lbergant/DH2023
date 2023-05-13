//
//  TakeControlApp.swift
//  TakeControl
//
//  Created by Luka Bergant on 13/05/2023.
//

import SwiftUI

@main
struct TakeControlApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
