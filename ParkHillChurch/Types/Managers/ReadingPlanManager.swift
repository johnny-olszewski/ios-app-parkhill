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
    
    func fetchReadingPlans(with id: String, from modelContext: ModelContext) throws -> BreadPlan? {
        print("ReadingPlanManager.fetchReadingPlan(with: \(id) from: ModelContext)")
        let descriptor = FetchDescriptor<BreadPlan>(
            predicate: #Predicate { $0.id == id }
        )
        
        do {
            let matchingPlans = try modelContext.fetch(descriptor)
            if matchingPlans.isEmpty {
                return try loadReadingPlan(with: id, from: modelContext)
            }
            return matchingPlans.first
        } catch {
            print("ERROR: \(error)")
            throw error
        }
    }
    
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws -> BreadPlan? {
        print("ReadingPlanManager.loadReadingPlan(with: \(id) from: ModelContext)")
        do {
            let loadedPlan = try ReadingPlan.initFromJson(fileName: "ph_bread_2025")
            
            switch loadedPlan.type {
            case .bread:
                let breadPlan = BreadPlan(readingPlan: loadedPlan)
                modelContext.insert(breadPlan)
                
                try modelContext.save()
                return breadPlan
            default: break
            }
        } catch {
            print("ERROR: \(error)")
            throw error
        }
        
        return nil
    }
    
}


