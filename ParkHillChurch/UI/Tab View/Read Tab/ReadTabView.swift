//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ReadTabView: View {
    
    let availableSections: [Section] = [.read, .bread]
    
    @State private var selectedSection: Section = .read
    
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
        VStack {
            HStack {
                ForEach(availableSections) { section in
                    pickerButton(for: section)
                }
            }
            
            ScrollView {
                LazyVStack {
                    ForEach(0..<1000) { index in
                        VStack(alignment: .leading) {
                            NavigationLink(value: index) {
                                Text("Item \(index)".uppercased())
                                    .fontWeight(.thin)
                                    .foregroundStyle(.primaryText)
                            }
                            Divider()
                                .padding(.horizontal)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .mask {
                Rectangle()
                    .fill(LinearGradient(colors: [.black, .clear], startPoint: .init(x: 0.5, y: 0.1), endPoint: .top))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 18))
                }
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
    
    @ViewBuilder
    func pickerButton(for section: Section) -> some View {
        Button {
            
        } label: {
            ZStack {
                Capsule()
                    .fill(selectedSection == section ? Color.primaryText : .clear)
                    .stroke(Color.primaryText, lineWidth: 1)
                    .frame(width: 60, height: 24)
                
                Text(section.rawValue.uppercased())
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(selectedSection == section ? Color.primaryBackground : .primaryText)
            }
        }
    }
}

#Preview {
    ReadTabView()
}

