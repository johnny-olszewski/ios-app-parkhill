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
