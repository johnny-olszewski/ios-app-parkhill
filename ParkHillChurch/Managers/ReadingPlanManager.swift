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
                
                do {
                    try modelContext.save()
                } catch {
                    logger.error("Error saving BreadPlan: \(error)")
                }
            default: break
            }
        } catch {
            throw error
        }
            
    }
}

extension Logger {
    static let readingPlanManager = Logger(subsystem: Bundle.main.bundleIdentifier ?? "ParkHillChurch", category: "ReadingPlanManager")
}

@Model
class BreadPlan {
    
    @Attribute(.unique) var id: String
    var name: String
    var planDescription: String
    var updateURL: String
    var version: Double
    
    init(id: String, name: String, planDescription: String, updateURL: String, version: Double) {
        self.id = id
        self.name = name
        self.planDescription = planDescription
        self.updateURL = updateURL
        self.version = version
    }
    
    init(readingPlan: ReadingPlan) {
        self.id = readingPlan.id
        self.name = readingPlan.name
        self.planDescription = readingPlan.description
        self.updateURL = readingPlan.updateURL
        self.version = readingPlan.version
        
        print("BreadPlan.init(readingPlan:)")
    }
}
