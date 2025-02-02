//
//  Day+CustomStringConvertible.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation

extension ReadingPlan.Day: CustomStringConvertible {
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return "\(date.formatted(date: .abbreviated, time: .omitted)) \(isCompleted)"
    }
}