//
//  ReadingPlanHeader.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/25/25.
//

import SwiftUI

struct ReadingPlanHeader: View {
    
    var imageName: String
    var title: String
    var subtitle: String?
    var caption: String?
    
    var headerHeight: CGFloat = 300
    
    @Binding var selectedViewType: ReadingPlanView.ViewType
    
    var body: some View {
        Rectangle()
            .overlay {
                HeaderImage
            }
            .overlay(alignment: .bottomLeading) {
                
                TextStack
                    .foregroundStyle(.primaryText)
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .background {
                        LinearGradient(
                            colors: [
                                .primaryBackground.opacity(0),
                                .primaryBackground.opacity(1)
                            ],
                            startPoint: .init(x: 0.5, y: 0.2),
                            endPoint: .bottom
                        )
                    }
            }
            .asStretchyHeader(startingHeight: headerHeight)
    }
    
    var HeaderImage: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .scaleEffect(1.3, anchor: .leading)
            .frame(height: headerHeight)
    }
    
    var TextStack: some View {
        HStack(alignment: .lastTextBaseline, spacing: 24) {
            VStack(alignment: .leading) {
                if let subtitle {
                    Text(subtitle)
                        .font(.headline)
                        .foregroundStyle(.primaryText.opacity(0.7))
                }
                
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primaryText)
                
                if let caption {
                    Text(caption)
                        .font(.callout)
                        .foregroundStyle(.primaryText.opacity(0.7))
                        .lineLimit(3)
                }
            }
            
            Spacer()
            
            ReadingPlanViewTypeSelector(selectedViewType: $selectedViewType)
            .padding()
        }
    }
}

#Preview {
    
    ZStack {
        Color.primaryBackground
            .ignoresSafeArea()
        
        ScrollView {
            ReadingPlanHeader(
                imageName: "bread_cover",
                title: "Bread",
                subtitle: "Park Hill Church",
                caption: "A year praying through the whole bible in unity",
                selectedViewType: .constant(.list)
            )
        }
        .ignoresSafeArea()
    }
}
