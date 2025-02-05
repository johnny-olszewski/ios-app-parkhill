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
    final class Day: Decodable {
        var date: String // TODO: Make date
        var isCompleted: Bool = false
        var passages: [BiblePassage]
        
        init(date: String, passages: [BiblePassage]) {
            self.date = date
            self.passages = passages
        }
        
        enum CodingKeys: String, CodingKey {
            case date
            case passages
        }
        
        convenience init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let date = try container.decode(String.self, forKey: .date)
            let passages = try container.decode([BiblePassage].self, forKey: .passages)
            self.init(date: date, passages: passages)
        }
    }
}
