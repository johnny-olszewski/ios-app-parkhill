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

class ReadingPlanManager: ObservableObject {
    
    let logger = Logger.readingPlanManager
    let planId: String
    let modelContext: ModelContext
    @Published var readingPlan: ReadingPlan?
    
    init(planId: String, modelContext: ModelContext) {
        self.planId = planId
        self.modelContext = modelContext
        
        do {
            self.readingPlan = try fetchReadingPlan()
        } catch {
            print("Failed to fetch ReadingPlan: \(error)")
            self.readingPlan = nil
        }
    }
    
    func getDay(_ index: Int) -> BreadReadingPlan.Day? {
        return getAllDays()?.first { $0.dayOfPlan == index } ?? nil
    }
    
    func getAllDays() -> [BreadReadingPlan.Day]? {
        if let breadReadingPlan = readingPlan as? BreadReadingPlan, let sections = breadReadingPlan.sections {
            let allDays: [BreadReadingPlan.Day] = sections.flatMap { section in
                section.days ?? []
            }
            
            return allDays.sorted { $0.date < $1.date }
        }
        
        return nil
    }
    
    // MARK: - ReadingPlanProviding
    
    func fetchReadingPlan(with id: String? = nil, from modelContext: ModelContext? = nil) throws -> ReadingPlan? {
        let id = id ?? self.planId
        let modelContext = modelContext ?? self.modelContext
        
        let descriptor = FetchDescriptor<BreadReadingPlan>( // needs to be ReadingPlan
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
    
    func loadReadingPlan(with id: String? = nil, from modelContext: ModelContext? = nil) throws -> ReadingPlan? {
        let id = id ?? self.planId
        let modelContext = modelContext ?? self.modelContext
        
        do {
            guard let url = Bundle.main.url(forResource: "DEBUG_plans", withExtension: "json") else { return nil } // TODO: Should throw, TEST FILE
            let data = try Data(contentsOf: url)
            
            let plans: [ReadingPlan] = try loadPlans(from: data)
            
            for plan in plans {
                if plan.id == id {
                    
                    if let breadPlan = plan as? BreadReadingPlan {
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
            guard let type: ReadingPlanType =  .init(rawValue: rawPlan["type"] as? String ?? "unknown") else {
                continue // skip if missing
            }
            
            guard let planID = rawPlan["id"] as? String else {
                continue
            }
            
            decoder.userInfo[.planID] = planID
            
            // 4) Decode concrete plan
            switch type {
            case .bread:
                let plan = try decoder.decode(BreadReadingPlan.self, from: planData)
                results.append(plan)
            case .daily:
                let plan = try decoder.decode(DailyPlan.self, from: planData)
                results.append(plan)
            case .unknown:
                print("Unknown plan type '\(type)'; skipping.")
            }
        }
        
        return results
    }
}


