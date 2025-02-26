//
//  ManagerFactory.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/21/25.
//

import SwiftUI
import SwiftData

class ManagerFactory {
    
    static func generateReadingPlanManager(planId: String, modelContext: ModelContext) -> ReadingPlanManager {
        return ReadingPlanManager(planId: planId, modelContext: modelContext)
    }
}
