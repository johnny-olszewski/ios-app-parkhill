//
//  ReadingPlanViewModel.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import Foundation
import SwiftData
import SwiftUI

class ReadingPlanViewModel: ObservableObject {
    
    let planId: String
    
    let readingPlanManager: ReadingPlanManager = .shared
    
    init(planId: String) {
        self.planId = planId
    }
}
