//
//  ReadTabViewModel.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation

class ReadTabViewModel {
    
    let readingPlanManager: ReadingPlanManager = .shared
    
    let availableSections: [ReadTabView.Section] = [.read, .bread]
    
    init() { }
}
