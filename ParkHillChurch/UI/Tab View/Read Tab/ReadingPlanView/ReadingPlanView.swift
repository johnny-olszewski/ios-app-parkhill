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
        .navigationDestination(for: BreadDay.self) { day in
            Text("\(day.date.formatted(date: .numeric, time: .omitted))")
            Text(day.passages.description)
        }
        
    }
    
    func daysList<T: Listable & Hashable>(items: [T]) -> some View {
        LazyVStack {
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading) {
                    NavigationLink(value: item) {
                        VStack(alignment: .leading) {
                            Text(item.listTitle.uppercased())
                                .font(.system(size: 13, weight: .thin))
                                .foregroundStyle(.primaryText)
                                .padding(.vertical, 2)
                            
                            if let subTitle = item.listSubtitle {
                                Text(subTitle)
                                    .font(.system(size: 15, weight: .light))
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
        .padding(.bottom, 100)
    }
}

#Preview {
    ReadingPlanView(planId: "bread_2025")
}
