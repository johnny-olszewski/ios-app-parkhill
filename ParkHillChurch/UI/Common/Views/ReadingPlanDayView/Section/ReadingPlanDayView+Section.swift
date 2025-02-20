//
//  Section.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

extension ReadingPlanDayView {
    enum Section: CaseIterable, Hashable {
        
        private enum Constants {
            static let breathePrompt: String = "Find a place where you can encounter God, ask him to fill the space, and then take a minute in the stillness."
            static let readPrompt: String = "Slowly read through the passage of the day, find a verse that stands out or grabs your attention. Write it down."
            static let encounterPrompt: String = "Take your chosen verse, meditate on it, and consider what God might be saying to you."
            static let applyPrompt: String = "Turn your focus outward, and think about how you might practically live out what God is saying today."
            static let devotePrompt: String = "Close by writing a simple prayer of devotion to God"
        }
        
        case breathe
        case read
        case encounter
        case apply
        case devote
        
        var title: String {
            switch self {
            case .breathe: "Breathe"
            case .read: "Read"
            case .encounter: "Encounter"
            case .apply: "Apply"
            case .devote: "Devote"
            }
        }
        
        var caption: String {
            switch self {
            case .breathe: Constants.breathePrompt
            case .read: Constants.readPrompt
            case .encounter: Constants.encounterPrompt
            case .apply: Constants.applyPrompt
            case .devote: Constants.devotePrompt
            }
        }
    }
}
