//
//  ReadingPlan.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation

struct ReadingPlan: Codable, Identifiable, Hashable {
    let id: String
    let type: PlanType
    let name: String
    let description: String
    let updateURL: String
    let version: Double
    let days: [ReadingPlan.Day]
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case description
        case updateURL = "update_url"
        case version
        case days
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        let typeString = try container.decode(String.self, forKey: .type)
        type = PlanType(rawValue: typeString) ?? .unknown
        
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        updateURL = try container.decode(String.self, forKey: .updateURL)
        version = try container.decode(Double.self, forKey: .version)
        days = try container.decode([ReadingPlan.Day].self, forKey: .days)
    }
    
    static func initFromJson(fileName: String) -> ReadingPlan? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let readingPlan = try JSONDecoder().decode(ReadingPlan.self, from: data)
            
            return readingPlan
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
}


