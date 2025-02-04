//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct MoreTabView: View {
    
    var availableListItems: [Item] = [.a, .b, .c, .d, .e]
    
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
            .navigationDestination(for: Item.self) { listItem in
                Text("\(listItem.rawValue) page")
            }
        }
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(availableListItems) { listItem in
                    VStack(alignment: .leading) {
                        NavigationLink(value: listItem) {
                            Text("List Item \(listItem.rawValue)".uppercased())
                                .fontWeight(.thin)
                                .foregroundStyle(.primaryText)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    MoreTabView()
}


