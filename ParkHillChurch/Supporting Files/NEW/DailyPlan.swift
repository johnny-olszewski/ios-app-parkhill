//
//  DailyPlan.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//


import Foundation
import SwiftData

@Model
final class DailyPlan: Decodable, ReadingPlan {
    var type: ReadingPlanType
    var id: String
    var category: String
    var name: String
    
    /// Renamed from `description` to `planDescription`.
    var planDescription: String

    init(
        type: ReadingPlanType,
        id: String,
        category: String,
        name: String,
        planDescription: String
    ) {
        self.type = type
        self.id = id
        self.category = category
        self.name = name
        self.planDescription = planDescription
    }

    enum CodingKeys: String, CodingKey {
        case type
        case id
        case category
        case name
        case planDescription = "description"  // The JSON key is still "description"
    }

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let typeString = try container.decode(String.self, forKey: .type)
        let type = ReadingPlanType(rawValue: typeString) ?? .unknown
        
        let id        = try container.decode(String.self, forKey: .id)
        let category  = try container.decode(String.self, forKey: .category)
        let name      = try container.decode(String.self, forKey: .name)
        let desc      = try container.decode(String.self, forKey: .planDescription)

        self.init(type: type, id: id, category: category, name: name, planDescription: desc)
    }
}
