//
//  Carousel.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/24/25.
//

import SwiftUI

struct Carousel: View {
    
    @Binding var selectedIndex: Int?
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .black, .gray, .orange]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(Array(colors.enumerated()), id: \.offset) { i, color in
                    Circle()
                        .animation(.default, value: i)
                        .id(i)
                        .foregroundStyle(color)
                        .containerRelativeFrame(.horizontal, count: 5, spacing: 8)
                        .scrollTransition { content, phase in
                            content
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(24, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $selectedIndex, anchor: .center)
    }
}

#Preview {
    
    @Previewable @State var index: Int? = 15
    
    Carousel(selectedIndex: $index)
}



public extension Color {
    
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
