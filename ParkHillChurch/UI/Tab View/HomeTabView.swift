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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingProfileSheet.toggle()
                    } label: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 18))
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
