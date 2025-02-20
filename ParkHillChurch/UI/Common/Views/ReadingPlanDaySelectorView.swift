//
//  ReadingPlanDaySelector.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/9/25.
//

import SwiftUI

struct ReadingPlanDaySelectorView: View {
    
    let readingPlan: ReadingPlan
    
    @Binding var isPresented: Bool
    @Binding var selectedDay: Int?
    
    var body: some View {
        ScrollView {
            if let breadPlan = readingPlan as? BreadReadingPlan, let sections = breadPlan.sections?.sorted(by: { $0.index < $1.index }) {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    ForEach(sections, id: \.self) { section in
                        if let days = section.days?.sorted(by: { $0.date < $1.date }) {
                            Section {
                                daysList(items: days)
                            } header: {
                                ZStack {
                                    Color.primaryBackground
                                        .opacity(0.8)
                                        .frame(maxWidth: .infinity)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    
                                    Text(section.title)
                                        .font(.custom("Baskerville", size: 18))
                                        .padding()
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
//    func daysList<T: Listable & Hashable>(items: [T]) -> some View {
    func daysList(items: [BreadReadingPlan.Day]) -> some View {
        LazyVStack {
            ForEach(items, id: \.self) { item in
                Button {
                    withAnimation {
                        selectedDay = Calendar.current.component(.dayOfYear, from: item.date)
                    }
                    isPresented = false
                } label: {
                    cell(for: item)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    func cell<T: Listable & Hashable>(for item: T) -> some View {
        VStack(alignment: .leading) {
            NavigationLink(value: item) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.listTitle.uppercased())
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(.primaryText)
                        
                        if let subTitle = item.listSubtitle {
                            Text(subTitle)
                                .font(.system(size: 15, weight: .thin))
                                .foregroundStyle(.primaryText)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    Spacer()
                    
                    if let day = item as? BreadReadingPlan.Day {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(day.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ReadingPlanDaySelector()
//}
