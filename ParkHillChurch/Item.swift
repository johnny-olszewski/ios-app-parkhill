//
//  Item.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/25/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
