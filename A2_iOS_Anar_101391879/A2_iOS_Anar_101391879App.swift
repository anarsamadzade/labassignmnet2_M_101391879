//
//  A2_iOS_Anar_101391879App.swift
//  A2_iOS_Anar_101391879
//
//  Created by Tech Atro on 2025-03-24.
//

import SwiftUI

@main
struct A2_iOS_Anar_101391879App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
