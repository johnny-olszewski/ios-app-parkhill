//
//  ParkHillChurchApp.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/25/25.
//

import SwiftUI
import SwiftData

@main
struct ParkHillChurchApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BreadReadingPlan.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        
        WindowGroup {
            ParkHillTabView()
            #if DEBUG
                .debugSheet {
                    DEBUGAppStateView()
                }
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}


