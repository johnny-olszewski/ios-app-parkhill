//
//  BreadDay+Listable.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//


import Foundation
import SwiftData
import os
import SwiftUI

extension BreadDay: Listable {
    var listTitle: String {
        return "\(date.formatted(date: .abbreviated, time: .omitted))"
    }
    
    var listSubtitle: String? {
        return self.passages.reduce(into: "") { result, passage in
            result += "\(passage)"
        }
    }
}