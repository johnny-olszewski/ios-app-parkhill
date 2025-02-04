//
//  ReadingPlanViewModel.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//


import SwiftUI
import SwiftData

class ReadingPlanViewModel: ObservableObject {
    
    let planId: String
    let readingPlanManager: ReadingPlanManager
    
    init(planId: String, readingPlanManager: ReadingPlanManager) {
        self.planId = planId
        self.readingPlanManager = readingPlanManager
    }
}
