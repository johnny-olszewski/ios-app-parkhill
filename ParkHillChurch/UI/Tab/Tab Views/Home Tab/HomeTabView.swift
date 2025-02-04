//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct HomeTabView: View {
    
    @State var isShowingProfileSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.primaryBackground
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    SectionSelector()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ProfileButton {
                        isShowingProfileSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingProfileSheet) {
                Text("Profile")
                    .presentationDetents([.fraction(0.75)])
            }
        }
    }
    
    @ViewBuilder var content: some View {
        Text("Home")
    }
}

#Preview {
    HomeTabView()
}
