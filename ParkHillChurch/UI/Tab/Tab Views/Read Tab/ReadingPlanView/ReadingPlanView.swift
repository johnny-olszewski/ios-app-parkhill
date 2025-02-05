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
    
    @ObservedObject var viewModel: ReadingPlanViewModel
    
    init(viewModel: ReadingPlanViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            if let readingPlan = try? viewModel.readingPlanManager.fetchReadingPlans(with: viewModel.planId, from: modelContext) {
                Text(readingPlan.name)
                Text(readingPlan.type.rawValue)
                
                if let breadPlan = readingPlan as? BreadPlan, let sections = breadPlan.sections {
                    ForEach(sections, id: \.self) { section in
                        if let days = section.days {
                            Section(section.title) {
                                daysList(items: days)
                            }
                        }
                    }
                }
            }
            
            
            
            //                if let breadPlan = readingPlan as? BreadPlan, let breadDays = breadPlan.days {
            //                    daysList(items: breadDays)
            //                }
            
            // TODO: If Daily Plan
        }
        //        .navigationDestination(for: BreadPlan.Day.self) { day in
        //            ReadingPlanDayView(day: day)
        //        }
    }
    
    func daysList<T: Listable & Hashable>(items: [T]) -> some View {
        LazyVStack {
            ForEach(items, id: \.self) { item in
                cell(for: item)
                    .padding(.horizontal)
            }
        }
        .padding(.bottom, 100)
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
