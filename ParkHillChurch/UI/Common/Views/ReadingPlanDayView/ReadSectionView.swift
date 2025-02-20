//
//  ReadSectionView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

struct ReadSectionView: View {
    
    @State private var selectedPassage: BiblePassage?
    
    var passages: [BiblePassage]
    
    var body: some View {
        Text("Read Section")
        
        VStack {
            ForEach(passages, id: \.self) { passage in
                passageButton(passage)
            }
        }
        .fullScreenCover(item: $selectedPassage) { passage in
            Text("\(passage)")
            
            Button("Close") {
                selectedPassage = nil
            }
        }
    }
    
    @ViewBuilder
    func passageButton(_ passage: BiblePassage) -> some View {
        Button {
            selectedPassage = passage
        } label: {
            HStack {
                Text(passage.description)
                    .font(.system(size: 16).lowercaseSmallCaps())
                    .foregroundStyle(.primaryText)
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "book.pages")
                            .font(.system(size: 18))
                    }
                    .foregroundStyle(.primaryText)
                }
            }
            .padding()
            .background {
                Color.brown.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}