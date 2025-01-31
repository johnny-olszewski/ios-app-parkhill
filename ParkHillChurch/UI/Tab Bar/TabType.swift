//
//  TabType.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//


import SwiftUI

enum TabType {
    case home
    case read
    case community
    case more
    
    var tabBarTitle: String {
        switch self {
        case .home: "Home"
        case .read: "Read"
        case .community: "Community"
        case .more: "More"
        }
    }
    
    var tabBarImageName: String {
        switch self {
            case .home: "house"
            case .read: "book"
            case .community: "person.3"
            case .more: "ellipsis"
        }
    }
    
    @ViewBuilder
    var tabView: some View {
        switch self {
            case .home: HomeTabView()
            case .read: ReadTabView()
            case .community: CommunityTabView()
            case .more: MoreTabView()
        }
    }
}
