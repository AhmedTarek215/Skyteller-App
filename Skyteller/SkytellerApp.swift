//
//  SkytellerApp.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 21/06/2026.
//

import SwiftUI

@main
struct SkytellerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
