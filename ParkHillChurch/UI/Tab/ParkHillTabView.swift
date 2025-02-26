//
//  ParkHillTabView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ParkHillTabView: View {
    
    @State private var selectedTab: TabType = .bread
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            ForEach(TabType.allCases, id: \.self) { tab in
                tab.tabView
                    .tabItem {
                        Label(tab.tabBarTitle, systemImage: tab.tabBarImageName)
                    }
            }
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground() // ✅ Ensures non-transparent tab bar
        appearance.backgroundColor = UIColor.systemBackground // ✅ Default iOS background
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    ParkHillTabView()
}


