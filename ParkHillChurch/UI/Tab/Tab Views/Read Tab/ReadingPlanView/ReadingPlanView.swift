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
    
    @ObservedObject var readingPlanManager: ReadingPlanManager
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
    }
    
    var body: some View {
        ScrollView {
            if let readingPlan = try? readingPlanManager.fetchReadingPlans() {
                Text(readingPlan.name)
                Text(readingPlan.type.rawValue)
                
                if let breadPlan = readingPlan as? BreadPlan, let sections = breadPlan.sections?.sorted(by: { $0.index < $1.index }) {
                    VStack {
                        ForEach(sections, id: \.self) { section in
                            if let days = section.days?.sorted(by: { $0.date < $1.date }) {
                                Section(section.title) {
                                    daysList(items: days)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            // TODO: If Daily Plan
        }
        .navigationDestination(for: BreadPlan.Day.self) { day in
            ReadingPlanDayView(day: day)
        }
                
    }
    
    func daysList<T: Listable & Hashable>(items: [T]) -> some View {
        LazyVStack {
            ForEach(items, id: \.self) { item in
                cell(for: item)
                    .padding(.horizontal)
            }
        }
    }
    
    func cell<T: Listable & Hashable>(for item: T) -> some View {
        VStack(alignment: .leading) {
            NavigationLink(value: item) {
                HStack {
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
                    
                    Spacer()
                    
                    if let day = item as? BreadPlan.Day {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.primaryText)
                                .opacity(day.isCompleted ? 1 : 0.5)
                        }
                    }
                }
            }
            Divider()
                .padding(.horizontal)
        }
    }
}

//#Preview {
//    ReadingPlanView(planId: "bread_2025")
//}
