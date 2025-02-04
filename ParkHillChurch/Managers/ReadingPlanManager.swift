//
//  ReadingPlanManager.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation
import SwiftData
import os
import SwiftUI

class ReadingPlanManager {
    
    static let shared: ReadingPlanManager = .init()
    let logger = Logger.readingPlanManager
    
    private init() { }
    
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws {
        do {
            let loadedPlan = try ReadingPlan.initFromJson(fileName: "ph_bread_2025")
            
            switch loadedPlan.type {
            case .bread:
                let breadPlan = BreadPlan(readingPlan: loadedPlan)
                modelContext.insert(breadPlan)
                
                try modelContext.save()
            default: break
            }
        } catch {
            throw error
        }
    }
}
