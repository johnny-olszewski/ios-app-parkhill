//
//  ReadTabView+Section.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import Foundation

extension ReadTabView {
    enum Section: String, Identifiable {
        case read
        case bread
        
        var id: String { self.rawValue }
    }
}
