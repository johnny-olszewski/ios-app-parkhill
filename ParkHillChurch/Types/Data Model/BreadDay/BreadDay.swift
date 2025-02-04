//
//  BreadDay.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation
import SwiftData
import os
import SwiftUI

@Model
class BreadDay: Hashable {
    
    @Attribute(.unique) var id: String
    var plan: BreadPlan?
    var date: Date
    var passages: [BiblePassage]
    
    init(id: String, date: Date, passages: [BiblePassage]) {
        self.id = id
        self.date = date
        self.passages = passages
    }
    
    init(planId: String, planDay: ReadingPlan.Day) {
        self.id = "\(planId)-\(planDay.date.formatted(.iso8601.month().day()))"
        self.date = planDay.date
        self.passages = planDay.passages
        
        print("BreadDay.init(ReadingPlan.Day: ")
    }
}