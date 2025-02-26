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
    let modelContext: ModelContext?
    @Published var readingPlan: BreadReadingPlan?
    
    init(planId: String, modelContext: ModelContext? = nil) {
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
        if let sections = readingPlan?.sections {
            let allDays: [BreadReadingPlan.Day] = sections.flatMap { section in
                section.days ?? []
            }
            
            return allDays.sorted { $0.date < $1.date }
        }
        
        return nil
    }
    
    func getNumberOfDays() -> Int {
        getAllDays()?.count ?? 0
    }
    
    // MARK: - ReadingPlanProviding
    
    func fetchReadingPlan(with id: String? = nil, from modelContext: ModelContext? = nil) throws -> BreadReadingPlan? {
        let id = id ?? self.planId
        let modelContext = modelContext ?? self.modelContext
        
        let descriptor = FetchDescriptor<BreadReadingPlan>( // needs to be ReadingPlan
            predicate: #Predicate { $0.id == id }
        )
        
        do {
            var matchingPlans: [BreadReadingPlan] = []
            
            if let modelContext {
                matchingPlans = try modelContext.fetch(descriptor)
            }
            
            if matchingPlans.isEmpty {
                return try loadReadingPlanFromJSON(with: id, from: modelContext)
            }
            
            return matchingPlans.first
        } catch {
            print("ERROR: \(error)")
            throw error
        }
    }
    
    func loadReadingPlanFromJSON(with id: String? = nil, from modelContext: ModelContext? = nil) throws -> BreadReadingPlan? {
        let id = id ?? self.planId
        let modelContext = modelContext ?? self.modelContext
        
        do {
            guard let url = Bundle.main.url(forResource: "DEBUG_plans", withExtension: "json") else { return nil } // TODO: Should throw, TEST FILE
            let data = try Data(contentsOf: url)
            
            let plans: [BreadReadingPlan] = try decodePlans(from: data)
            
            for plan in plans {
                if plan.id == id {
                    
                    if let modelContext {
                        modelContext.insert(plan)
                    } else {
                        logger.debug("No model context provided. Cannot fetch reading plan.")
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
    
    func decodePlans(from jsonData: Data) throws -> [BreadReadingPlan] {
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
        var results: [BreadReadingPlan] = []
        
        // 3) Convert each plan dict → Data → decode by "type"
        for rawPlan in rawPlans {
            // Convert to Data
            let planData = try JSONSerialization.data(withJSONObject: rawPlan)
            
            guard let planID = rawPlan["id"] as? String else {
                continue
            }
            
            decoder.userInfo[.planID] = planID
            
            // 4) Decode concrete plan
            let plan = try decoder.decode(BreadReadingPlan.self, from: planData)
            results.append(plan)
        }
        
        return results
    }
}


