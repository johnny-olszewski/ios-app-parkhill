//
//  Section.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/5/25.
//


import Foundation
import SwiftData

extension BreadPlan {
    
    @Model
    final class Section: Decodable, Identifiable {
        // MARK: - Properties
        var id: String { "\(index)" }
        var index: Int
        var title: String
        @Relationship(deleteRule: .cascade, inverse: \Day.section)
        var days: [Day]?
        var plan: BreadPlan?
        
        // MARK: - Designated Initializer
        init(index: Int, title: String, days: [Day]? = nil) {
            self.index = index
            self.title = title
            self.days = days
        }
        
        // MARK: - Decodable Conformance
        enum CodingKeys: String, CodingKey {
            case index
            case title
            case days
        }
        
        // Required initializer to conform to Decodable
        convenience init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let index = try container.decode(Int.self, forKey: .index)
            let title = try container.decode(String.self, forKey: .title)
            print("Decoding Section: \(title)")
            let days = try container.decodeIfPresent([Day].self, forKey: .days)
            
            // Calling the designated initializer
            self.init(index: index, title: title, days: days)
        }
    }
}
