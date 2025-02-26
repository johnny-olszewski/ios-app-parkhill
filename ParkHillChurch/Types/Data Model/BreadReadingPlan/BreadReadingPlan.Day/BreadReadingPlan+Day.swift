//
//  Day.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/5/25.
//


import Foundation
import SwiftData

extension BreadReadingPlan {
    
    @Model
    final class Day: Decodable, Identifiable, Hashable {
        var id: String
        var dayOfPlan: Int
        var date: Date
        var dateCompleted: Date?
        var passages: [BiblePassage]
        var section: Section?
        
        init(id: String, dayOfPlan: Int, date: Date, passages: [BiblePassage]) {
            self.id = id
            self.dayOfPlan = dayOfPlan
            self.date = date
            self.passages = passages
        }
        
        enum CodingKeys: String, CodingKey {
            case dayOfPlan
            case date
            case passages
        }
        
        convenience init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let passages = try container.decode([BiblePassage].self, forKey: .passages)
            
            let dayOfPlan = try container.decode(Int.self, forKey: .dayOfPlan)
            
            // decode planId from userInfo
            guard let planID = decoder.userInfo[.planID] as? String else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "Missing planID in decoder.userInfo"
                ))
            }
            let dayID: String = "\(planID)-\(dayOfPlan)"
            
            var newDate: Date = Calendar.current.firstDayOfYear(2025) ?? Date()
            newDate = Calendar.current.date(byAdding: .day, value: dayOfPlan, to: newDate) ?? Date()
            
            self.init(id: dayID, dayOfPlan: dayOfPlan, date: newDate, passages: passages)
        }
        
        public func toggleDate() {
            if dateCompleted == nil {
                dateCompleted = Date()
            } else {
                dateCompleted = nil
            }
        }
    }
}

extension Calendar {
    /// Returns the first day of the given year as a `Date`
    func firstDayOfYear(_ year: Int) -> Date? {
        return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))
    }
}
