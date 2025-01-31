//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ReadTabView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
        }
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<1000) { index in
                    NavigationLink(value: index) {
                        Text("Row \((index))")
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person.circle")
                    .font(.system(size: 18))
            }
        }
    }
}

#Preview {
    ReadTabView()
}
