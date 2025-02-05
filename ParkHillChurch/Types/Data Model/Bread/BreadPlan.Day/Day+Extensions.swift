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

extension BreadPlan.Day: Listable, Hashable {
    var listTitle: String {
        return date// "\(date.formatted(date: .abbreviated, time: .omitted))"
    }
    
    var listSubtitle: String? {
//        return self.passages.reduce(into: "") { result, passage in
//            result += "\(passage) "
//        }
        
        let passageStrings: [String] = self.passages.map { "\($0)"}
        return passageStrings.joined(separator: ", ")
    }
}
