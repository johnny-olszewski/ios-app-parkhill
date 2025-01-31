//
//  SectionSelector.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import SwiftUI

struct SectionSelector: View {
    
    let sections: [HomeTabView.Section] = [.home, .generosity, .serving, .community, .about]
    
    @State var selectedSection: HomeTabView.Section.ID?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(sections) { section in
                    Button {
                        
                    } label: {
                        Text(section.title.uppercased())
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.primaryText)
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.trailing) // to account for fade
        }
        .scrollPosition(id: $selectedSection)
        .scrollIndicators(.hidden)
        .mask {
            Rectangle()
                .fill(LinearGradient(colors: [.black, .clear], startPoint: .init(x: 0.8, y: 0.5), endPoint: .trailing))
            
        }
    }
}

#Preview {
    SectionSelector()
}


