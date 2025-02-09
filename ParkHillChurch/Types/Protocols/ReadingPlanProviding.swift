//
//  ReadingPlanProviding.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//


import SwiftUI
import SwiftData

protocol ReadingPlanProviding {
    
    func fetchReadingPlans(with id: String, from modelContext: ModelContext) throws -> ReadingPlan?
    func loadReadingPlan(with id: String, from modelContext: ModelContext) throws -> ReadingPlan?
}
