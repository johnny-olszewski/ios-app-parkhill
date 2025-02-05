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
    
    func fetchReadingPlans(with id: String, from modelContext: ModelContext) throws -> ReadingPlan? {
        print("ReadingPlanManager.fetchReadingPlan(with: \(id) from: ModelContext)")
        let descriptor = FetchDescriptor<BreadPlan>( // needs to be ReadingPlan
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
    
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws -> ReadingPlan? {
        print("ReadingPlanManager.loadReadingPlan(with: \(id) from: ModelContext)")
        do {
            guard let url = Bundle.main.url(forResource: "DEBUG_plans", withExtension: "json") else { return nil } // TODO: Should throw, TEST FILE
            let data = try Data(contentsOf: url)

            let plans: [ReadingPlan] = try loadPlans(from: data)
            
            for plan in plans {
                if plan.id == id {
                    
                    if let breadPlan = plan as? BreadPlan {
                        modelContext.insert(breadPlan) // Now the compiler sees a concrete @Model
                    } else if let dailyPlan = plan as? DailyPlan {
                        modelContext.insert(dailyPlan)
                    } else {
                        // Unknown plan type; do nothing or handle error
                    }
                    
                    return plan
                }
            }
        } catch {
            print("ERROR: \(error)")
            throw error
        }
        
        return nil
    }
    
    func loadPlans(from jsonData: Data) throws -> [ReadingPlan] {
        // 1) Parse top-level as dictionary
        let topLevel = try JSONSerialization.jsonObject(with: jsonData, options: [])
        guard let dictionary = topLevel as? [String: Any] else {
            throw DecodingError
                .dataCorrupted(.init(codingPath: [],debugDescription: "Top-level JSON is not a dictionary."))
        }
        
        // 2) Extract plans array
        guard let rawPlans = dictionary["plans"] as? [[String: Any]] else {
            // If there's no "plans" key or it's not an array of dicts, return empty or throw
            return []
        }
        
        let decoder = JSONDecoder()
        var results: [ReadingPlan] = []
        
        // 3) Convert each plan dict → Data → decode by "type"
        for rawPlan in rawPlans {
            // Convert to Data
            let planData = try JSONSerialization.data(withJSONObject: rawPlan)
            
            // Peek at "type"
            guard let type = rawPlan["type"] as? String else {
                continue // skip if missing
            }
            
            // 4) Decode concrete plan
            switch type {
            case "bread":
                let plan = try decoder.decode(BreadPlan.self, from: planData)
                results.append(plan)
            case "daily":
                let plan = try decoder.decode(DailyPlan.self, from: planData)
                results.append(plan)
            default:
                // Unknown type
                print("Unknown plan type '\(type)'; skipping.")
            }
        }
        
        return results
    }
    
    
}


