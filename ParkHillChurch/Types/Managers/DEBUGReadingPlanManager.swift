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
    
    override init() {
        super.init()
    }
    
    override func loadReadingPlan(with id: String, from modelContext: ModelContext) throws -> BreadPlan?  {
        print("DEBUGReadingPlanManagerloadReadingPlan(with: \(id) from: ModelContext)")
        return nil
    }
    
    override func fetchReadingPlans(with planId: String, from modelContext: ModelContext) throws -> BreadPlan? { return nil }
}

#endif
