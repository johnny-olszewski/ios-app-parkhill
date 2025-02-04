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
    var isCompleted: Bool
    
    init(id: String, date: Date, passages: [BiblePassage], isCompleted: Bool = false) {
        self.id = id
        self.date = date
        self.passages = passages
        self.isCompleted = isCompleted
    }
    
    init(planId: String, planDay: ReadingPlan.Day) {
        self.id = "\(planId)-\(planDay.date.formatted(.iso8601.month().day()))"
        self.date = planDay.date
        self.passages = planDay.passages
        self.isCompleted = false
        
        print("BreadDay.init(ReadingPlan.Day: ")
    }
}
