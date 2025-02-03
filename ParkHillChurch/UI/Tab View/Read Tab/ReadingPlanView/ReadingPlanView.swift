//
//  ReadingPlanView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/2/25.
//

import SwiftUI
import SwiftData

struct ReadingPlanView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var readingPlans: [BreadPlan]
    
    let readingPlanManager: ReadingPlanManager = .shared
    let planId: String
    
    init(planId: String) {
        self.planId = planId
        
        _readingPlans = Query(filter: #Predicate { $0.id == planId} )
    }
    
    var body: some View {
        ScrollView {
            if let plan = readingPlans.first {
                Text(plan.name)
                Text(plan.planDescription)
                Text(plan.updateURL)
                
                daysList(items: plan.days)
            }
        }
        .task {
            try? readingPlanManager.loadReadingPlan(with: planId, from: modelContext)
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
