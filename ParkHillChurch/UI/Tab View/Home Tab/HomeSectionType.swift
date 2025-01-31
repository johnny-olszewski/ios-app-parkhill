//
//  HomeSectionType.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//


import SwiftUI

enum HomeSectionType: Identifiable {
    
    case home
    case generosity
    case serving
    case community
    case about
    
    var id: String { title }
    
    var title: String {
        switch self {
            case .home: return "Home"
            case .generosity: return "Generosity"
            case .serving: return "Serving"
            case .community: return "Community"
            case .about: return "About"
        }
    }
}