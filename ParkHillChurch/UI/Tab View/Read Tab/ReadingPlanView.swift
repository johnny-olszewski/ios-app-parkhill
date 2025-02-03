//
//  ReadingPlanView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import SwiftUI

struct ReadingPlanView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @StateObject var viewModel: ReadingPlanViewModel
    
    init(planId: String) {
        _viewModel = StateObject(wrappedValue: ReadingPlanViewModel(planId: planId))
    }
    
    var body: some View {
        ScrollView {
            if let readingPlan = ReadingPlanManager.shared.readingPlan {
                daysList(items: readingPlan.days)
            }
        }
    }
    
    func daysList<T: Listable & Hashable>(items: [T]) -> some View {
        LazyVStack {
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading) {
                    NavigationLink(value: item) {
                        VStack {
                            Text(item.listTitle.uppercased())
                                .fontWeight(.thin)
                                .foregroundStyle(.primaryText)
                            
                            if let subTitle = item.listSubtitle {
                                Text(subTitle)
                                    .fontWeight(.light)
                                    .foregroundStyle(.primaryText)
                            }
                        }
                    }
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ReadingPlanView(planId: "bread_2025")
}
