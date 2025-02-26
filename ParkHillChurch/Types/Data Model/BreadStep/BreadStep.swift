//
//  BreadStep.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/26/25.
//

import Foundation

enum BreadStep: String, CaseIterable, Hashable {
    
    case breathe
    case read
    case encounter
    case apply
    case devote
    
    var prompt: String {
        switch self {
        case .breathe: "Find a place where you can encounter God, ask him to fill the space, and then take a minute in the stillness."
        case .read: "Slowly read through the passage of the day, find a verse that stands out or grabs your attention. Write it down."
        case .encounter: "Take your chosen verse, meditate on it, and consider what God might be saying to you."
        case .apply: "Turn your focus outward, and think about how you might practically live out what God is saying today."
        case .devote: "Close by writing a simple prayer of devotion to God"
        }
    }
}
