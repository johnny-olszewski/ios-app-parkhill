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
    case watch
    case more
    
    var tabBarTitle: String {
        switch self {
        case .home: "Home"
        case .read: "Read"
        case .watch: "Watch"
        case .more: "More"
        }
    }
    
    var tabBarImageName: String {
        switch self {
            case .home: "house"
            case .read: "book"
            case .watch: "playpause"
            case .more: "ellipsis"
        }
    }
    
    @ViewBuilder
    var tabView: some View {
        switch self {
            case .home: HomeTabView()
            case .read: ReadTabView()
            case .watch: WatchTabView()
            case .more: MoreTabView()
        }
    }
}
