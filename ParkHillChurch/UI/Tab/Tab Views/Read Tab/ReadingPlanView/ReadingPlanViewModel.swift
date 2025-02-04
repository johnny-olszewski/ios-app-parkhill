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
    let provider: ReadingPlanProviding
    
    init(planId: String, provider: ReadingPlanProviding) {
        self.planId = planId
        self.provider = provider
    }
}
