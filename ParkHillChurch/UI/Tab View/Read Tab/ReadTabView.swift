//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ReadTabView: View {
    
    @State private var selectedSection: Section = .bread
    
    let viewModel: ReadTabViewModel = .init()
    
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
                ForEach(viewModel.availableSections) { section in
                    pickerButton(for: section)
                }
            }
            
            if let readingPlan = viewModel.readingPlanManager.readingPlan {
                VStack(alignment: .leading) {
                    Text(readingPlan.name)
                    Text(readingPlan.description)
                    Text(readingPlan.updateURL)
                    Text("\(readingPlan.version)")
                    ForEach(readingPlan.days, id: \.self) { dayPlan in
                        Text(dayPlan.date.description)
                    }
                }
            }
            
            numberList
        }
    }
    
    @ViewBuilder
    var numberList: some View {
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person.circle")
                    .font(.system(size: 18))
            }
        }
        .ignoresSafeArea(edges: [.bottom])
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
