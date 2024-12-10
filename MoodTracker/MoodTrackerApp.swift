//
//  MoodTrackerApp.swift
//  MoodTracker
//
//  Created by Yujin on 12/9/24.
//

import SwiftUI

@main
struct MoodTrackerApp: App {
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
