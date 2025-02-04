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

class ReadingPlanManager: ObservableObject, ReadingPlanProviding {
    
    let logger = Logger.readingPlanManager
    
    init() { }
    
    // MARK: - ReadingPlanProviding
    
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws {
        print("ReadingPlanManager.loadReadingPlan(with: \(id) from: ModelContext)")
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
    
    func fetchReadingPlans(context: ModelContext, planId: String) throws -> [BreadPlan] {
        let descriptor = FetchDescriptor<BreadPlan>(
            predicate: #Predicate { $0.id == planId }
        )
        do {
            return try context.fetch(descriptor)
        } catch {
            throw error
        }
    }
    
}


