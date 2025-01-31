//
//  ReadingPlanManager.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation

class ReadingPlanManager {
    
    static let shared: ReadingPlanManager = .init()
    
    var readingPlan: ReadingPlan?
    
    private init() {
        loadReadingPlans()
    }
    
    private func loadReadingPlans() {
        self.readingPlan = ReadingPlan.initFromJson(fileName: "ph_bread_2025")
    }
}
