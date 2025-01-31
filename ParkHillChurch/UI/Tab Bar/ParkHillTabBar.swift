//
//  ParkHillTabBar.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ParkHillTabBar: View {
    
    @Binding var selectedTab: TabType
    
    let tabs: [TabType] = [.home, .read, .watch, .more]
    
    var body: some View {
        Grid {
            GridRow(alignment: .lastTextBaseline) {
                ForEach(tabs, id: \.self) { tab in
                    tabBarButton(for: tab)
                        .frame(width: 75)
                        .padding(.vertical, 6)
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    @ViewBuilder
    private func tabBarButton(for tab: TabType) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack {
                Image(systemName: tab.tabBarImageName)
                    .padding(.bottom, 2)
                Text(tab.tabBarTitle.uppercased())
                    .font(.system(size: 10, weight: .light))
            }
            .foregroundStyle(Color.primaryText)
        }
    }
}

//#Preview {
//    ParkHillTabBar(selectedTab: )
//}


