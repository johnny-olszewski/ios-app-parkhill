//
//  PlanDay.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//


import Foundation

struct PlanDay: Codable, Hashable {
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .date)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate] // Adjust format based on your JSON format
        
        if let parsedDate = formatter.date(from: dateString) {
            self.date = parsedDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match expected format")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        let dateString = formatter.string(from: date)
        try container.encode(dateString, forKey: .date)
    }
}

extension PlanDay: CustomStringConvertible {
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: date)
    }
}
