//
//  DEBUGReadingPlanManager+ReadingPlanProviding.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//

#if DEBUG

import Foundation
import SwiftData


extension DEBUGReadingPlanManager: ReadingPlanProviding {
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws {
        print("DEBUGReadingPlanManagerloadReadingPlan(with: \(id) from: ModelContext)")
    }
    
    func fetchReadingPlans(context: ModelContext, planId: String) throws -> [BreadPlan] { [] }
}

#endif
