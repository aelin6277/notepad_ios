//
//  NotepadAppApp.swift
//  NotepadApp
//
//  Created by Elin.Andersson on 2024-03-06.
//

import SwiftUI

@main
struct NotepadAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
