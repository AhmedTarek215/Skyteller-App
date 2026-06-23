//
//  SkytellerApp.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 21/06/2026.
//

import SwiftUI

@main
struct SkytellerApp: App {
    @StateObject private var themeManager = ThemeManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(themeManager)
        }
    }
}
