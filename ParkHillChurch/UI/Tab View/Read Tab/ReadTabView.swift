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
            .navigationDestination(for: PlanDay.self) { day in
                Text(day.description)
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
                listOf(items: readingPlan.days)
            }
            
        }
    }
    
    @ViewBuilder
    func listOf<T: Listable & Hashable>(items: [T]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        NavigationLink(value: item) {
                            Text(item.listTitle.uppercased())
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
