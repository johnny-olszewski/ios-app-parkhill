//
//  DEBUGReadingPlanManager+ReadingPlanProviding.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//


import Foundation

#if DEBUG

extension DEBUGReadingPlanManager: ReadingPlanProviding {
    
    func readingPlan(id: String) -> String {
        return "debug \(id)"
    }
}

#endif
