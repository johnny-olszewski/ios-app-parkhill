//
//  DEBUGReadingPlanManager.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//

#if DEBUG

import Foundation
import SwiftData

class DEBUGReadingPlanManager: ReadingPlanManager {
    
    @Published var shouldUseDebugReadingPlanManager: Bool
    
    init(planId: String, modelContext: ModelContext, shouldUseDebugReadingPlanManager: Bool) {
        self.shouldUseDebugReadingPlanManager = shouldUseDebugReadingPlanManager
        super.init(planId: planId, modelContext: modelContext)
    }
    
    override func loadReadingPlan(with id: String?, from modelContext: ModelContext?) throws -> ReadingPlan?  {
        if !shouldUseDebugReadingPlanManager {
            return try? super.loadReadingPlan(with: id, from: modelContext)
        }
        return nil
    }
    
    override func fetchReadingPlans(with planId: String?, from modelContext: ModelContext?) throws -> ReadingPlan? {
        if !shouldUseDebugReadingPlanManager {
            return try? super.fetchReadingPlans(with: planId, from: modelContext)
        }
        return nil
    }
}

#endif
