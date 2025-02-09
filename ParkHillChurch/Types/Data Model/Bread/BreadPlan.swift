//
//  BreadPlan.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//


import Foundation
import SwiftData

@Model
final class BreadPlan: Decodable, ReadingPlan, Identifiable, Hashable {
    // MARK: - Properties
    @Attribute(.unique) var id: String
    var type: ReadingPlanType
    var name: String
    var planDescription: String
    var update_url: String?
    var version: Double?
    @Relationship(deleteRule: .cascade, inverse: \Section.plan)
    var sections: [Section]?

    // MARK: - Custom (Designated) Init
    init(
        type: ReadingPlanType,
        id: String,
        name: String,
        planDescription: String,
        update_url: String? = nil,
        version: Double? = nil,
        sections: [Section]? = nil
    ) {
        self.type = type
        self.id = id
        self.name = name
        self.planDescription = planDescription
        self.update_url = update_url
        self.version = version
        self.sections = sections
    }
    
    // MARK: - Decodable Conformance
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case name
        case planDescription = "description"
        case update_url
        case version
        case sections
    }

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let typeString      = try container.decode(String.self, forKey: .type)
        let type = ReadingPlanType(rawValue: typeString) ?? .unknown
        
        
        let id              = try container.decode(String.self, forKey: .id)
        let name            = try container.decode(String.self, forKey: .name)
        let planDescription = try container.decode(String.self, forKey: .planDescription)
        let updateURL       = try container.decodeIfPresent(String.self, forKey: .update_url)
        let version         = try container.decodeIfPresent(Double.self, forKey: .version)
        let sections       = try container.decodeIfPresent([Section].self, forKey: .sections)
        
        self.init(
            type: type,
            id: id,
            name: name,
            planDescription: planDescription,
            update_url: updateURL,
            version: version,
            sections: sections
        )
    }
}
