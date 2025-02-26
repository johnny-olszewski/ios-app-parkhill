//
//  ReadingPlanDayList.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/25/25.
//

import SwiftUI

struct ReadingPlanListView: View {
    
    @Binding var path: NavigationPath
    
    var sections: [BreadReadingPlan.Section]
    
    var body: some View {
        LazyVStack {
            ForEach(sections.sorted { $0.index < $1.index }, id: \.self) { section in
                
                if let days: [BreadReadingPlan.Day] = section.days?.sorted(by: { $0.date < $1.date }) {
                    Section {
                        ForEach(days) { day in
                            
                            NavigationLink(value: day) {
                                dayCell(for: day)
                                    .padding(.horizontal)
                                    .foregroundStyle(.primaryText)
                            }
                        }
                    } header: {
                        sectionHeader(section.title)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
    
    private func sectionHeader(_ title: String) -> some View {
        Text("\(title)")
            .font(.system(size: 17, weight: .semibold).lowercaseSmallCaps())
    }
    
    private func dayCell(for day: BreadReadingPlan.Day) -> some View {
        HStack {
            
            Text("\(day.date.formatted(Date.FormatStyle().day(.twoDigits)))")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text("Day \(day.dayOfPlan)")
                    .font(.system(size: 13, weight: .light))
                
                if let subTitle = day.listSubtitle {
                    Text(subTitle)
                        .font(.system(size: 15, weight: .thin))
                }
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "checkmark")
                    .foregroundStyle(day.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
            }
        }
    }
}

#Preview {
    
    @Previewable @State var path = NavigationPath()

    let manager = ReadingPlanManager(planId: BreadReadingPlan.bread2025Id)
    
    if let sections = try? manager.loadReadingPlanFromJSON()?.sections {
        ScrollView {
            ReadingPlanListView(path: $path, sections: sections)
        }
    }
    
}
