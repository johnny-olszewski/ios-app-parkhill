//
//  BreadPlan.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation
import SwiftData
import os
import SwiftUI

@Model
class BreadPlan {
    
    @Attribute(.unique) var id: String
    var name: String
    var planDescription: String
    var updateURL: String
    var version: Double
    @Relationship(deleteRule: .cascade, inverse: \BreadDay.plan) var days: [BreadDay]
    
    init(id: String, name: String, planDescription: String, updateURL: String, version: Double, days: [BreadDay]) {
        self.id = id
        self.name = name
        self.planDescription = planDescription
        self.updateURL = updateURL
        self.version = version
        self.days = days
    }
    
    init(readingPlan: ReadingPlan) {
        self.id = readingPlan.id
        self.name = readingPlan.name
        self.planDescription = readingPlan.description
        self.updateURL = readingPlan.updateURL
        self.version = readingPlan.version
        self.days = readingPlan.days.map { day in .init(planId: readingPlan.id, planDay: day) }
        
        print("BreadPlan.init(readingPlan:)")
    }
}
