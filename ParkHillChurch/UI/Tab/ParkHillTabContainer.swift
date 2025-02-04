//
//  ParkHillTabView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ParkHillTabContainer: View {
    
    @State private var selectedTab: TabType = .read
    
    init() {}
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            selectedTab.tabView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ParkHillTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ParkHillTabContainer()
}


