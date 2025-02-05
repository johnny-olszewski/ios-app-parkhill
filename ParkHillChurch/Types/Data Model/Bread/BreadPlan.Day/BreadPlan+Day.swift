//
//  Day.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/5/25.
//


import Foundation
import SwiftData

extension BreadPlan {
    
    @Model
    final class Day: Decodable, Identifiable, Hashable {
        var id: String
        var date: Date
        var isCompleted: Bool = false
        var passages: [BiblePassage]
        var section: Section?
        
        init(id: String, date: Date, passages: [BiblePassage]) {
            self.id = id
            self.date = date
            self.passages = passages
        }
        
        enum CodingKeys: String, CodingKey {
            case date
            case passages
        }
        
        convenience init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Decode Date
            let dateString = try container.decode(String.self, forKey: .date)
            
            print("Decoding day: \(dateString)")
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate] // Adjust format based on your JSON format
            
            guard let parsedDate = formatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match expected format")
            }
            
            let passages = try container.decode([BiblePassage].self, forKey: .passages)
            
            // decode planId from userInfo
            guard let planID = decoder.userInfo[.planID] as? String else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "Missing planID in decoder.userInfo"
                ))
            }
            let dayID: String = "\(planID)-\(parsedDate.formatted(.iso8601.month().day()))"
            
            self.init(id: dayID, date: parsedDate, passages: passages)
        }
    }
}

extension BreadPlan {
    
    @Model
    final class Section: Decodable, Identifiable {
        // MARK: - Properties
        var title: String
        @Relationship(deleteRule: .cascade, inverse: \Day.section)
        var days: [Day]?
        var plan: BreadPlan?

        // MARK: - Designated Initializer
        init(title: String, days: [Day]? = nil) {
            self.title = title
            self.days = days
        }

        // MARK: - Decodable Conformance
        enum CodingKeys: String, CodingKey {
            case title
            case days
        }

        // Required initializer to conform to Decodable
        convenience init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let title = try container.decode(String.self, forKey: .title)
            print("Decoding Section: \(title)")
            let days = try container.decodeIfPresent([Day].self, forKey: .days)

            // Calling the designated initializer
            self.init(title: title, days: days)
        }
    }
}
