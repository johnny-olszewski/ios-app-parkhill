//
//  DEBUGAppStateView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//

import SwiftUI
import SwiftData

#if DEBUG

struct DEBUGAppStateView: View {
    
    @Environment(\.modelContext) var modelContext
    @Binding var debugAppState: DEBUGAppState
    @Query(sort: \BreadReadingPlan.name) var breadPlans: [BreadReadingPlan]

    var body: some View {
        NavigationStack {
            List {
                Toggle("Debug Reading Plan Provider", isOn: $debugAppState.isUsingDebugReadingPlanProvider)
                    .padding()
                
                Section("Objects") {
                    ForEach(breadPlans) { breadPlan in
                        NavigationLink("\(breadPlan.name)", value: breadPlan)
                    }
                }
            }
            .navigationDestination(for: BreadReadingPlan.self) { breadPlan in
                DEBUGBreadPlanView(breadPlan: breadPlan)
            }
        }
    }
}

struct DEBUGBreadPlanView: View {
    @Environment(\.modelContext) var modelContext
    var breadPlan: BreadReadingPlan
    
    var body: some View {
        List {
            if let sections = breadPlan.sections {
                
                ForEach(sections.sorted(by: { $0.index < $1.index }), id: \.id) { section in
                    sectionSection(for: section)
                }
            }
        }
        .navigationDestination(for: BreadReadingPlan.Day.self) { day in
            DEBUGDayView(day: day)
        }
    }
    
    @ViewBuilder
    func sectionSection(for section: BreadReadingPlan.Section) -> some View {
        Section("\(String(describing: index)): \(section.id)") {
            Text("\(section.title)")
            if let days = section.days {
                ForEach(days.sorted(by: { $0.date < $1.date }), id: \.id) { day in
                    dayCell(for: day)
                }
            }
        }
    }
    
    @ViewBuilder
    func dayCell(for day: BreadReadingPlan.Day) -> some View {
        NavigationLink(value: day) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("\(day.listTitle)")
                        .font(.body)
                    Text("\(type(of: day))")
                        .font(.caption)
                }
            }
        }
    }
}

struct DEBUGDayView: View {
    @Environment(\.modelContext) var modelContext
    var day: BreadReadingPlan.Day
    
    var body: some View {
        
        Text("\(day.listTitle)")
    }
}

#endif
