//
//  CryptoRadarApp.swift
//  CryptoRadar
//
//  Created by Ronaldo Andre on 15/05/26.
//

import SwiftUI
import CoreData

@main
struct CryptoRadarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
