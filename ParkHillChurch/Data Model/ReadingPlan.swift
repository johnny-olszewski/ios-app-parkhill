//
//  ReadingPlan.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation

struct ReadingPlan: Codable {
    let name: String
    let description: String
    let updateURL: String
    let version: Double

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case updateURL = "update_url"
        case version
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
