//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct WatchTabView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 18))
                }
            }
        }
    }
    
    @ViewBuilder var content: some View {
        Text("Watch")
    }
}

#Preview {
    WatchTabView()
}
