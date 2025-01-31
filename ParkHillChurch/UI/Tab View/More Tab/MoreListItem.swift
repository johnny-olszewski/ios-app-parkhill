//
//  MoreListItem.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//


import SwiftUI

enum MoreListItem: String, Identifiable {
    
    case a
    case b
    case c
    case d
    case e
    
    var id: String { self.rawValue }
}