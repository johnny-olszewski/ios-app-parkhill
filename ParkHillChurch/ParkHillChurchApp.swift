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
    
    #if DEBUG
    @State var debugAppState: DEBUGAppState = .init()
    #endif
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BreadPlan.self,
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
            ParkHillTabContainer()
            #if DEBUG
                .debugSheet {
                    DEBUGAppStateView(debugAppState: $debugAppState)
                }
                .environment(\.debugAppState, debugAppState)
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}




