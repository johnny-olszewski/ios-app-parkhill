//
//  ReadingPlanError.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation

extension ReadingPlan {
    enum ReadingPlanError: Error {
        case invalidJSON
        case decodingError
        case saveError
    }
}