//
//  TabType.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//


import SwiftUI

enum TabType: CaseIterable {
    case home
    case bread
    case watch
    case community
    case directory
    case contact
    
    var tabBarTitle: String {
        switch self {
        case .home: "Home"
        case .bread: "Read"
        case .watch: "Watch"
        case .community: "Community"
        case .directory: "Directory"
        case .contact: "Contact"
        }
    }
    
    var tabBarImageName: String {
        switch self {
            case .home: "house"
            case .bread: "book"
            case .watch: "playpause"
            case .community: "person"
            case .directory: "person"
            case .contact: "envelope"
        }
    }
    
    @ViewBuilder
    var tabView: some View {
        switch self {
            case .home: HomeTabView()
            case .bread: BreadTabView()
            case .watch: WatchTabView()
            case .community: Text("Community")
            case .directory: Text("Directory")
            case .contact: Text("Contact")
        }
    }
}
