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
    @State var isShowingDaySelector: Bool = false
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            
            LazyHStack {
                if let days = readingPlanManager.getDays() {
                    ForEach(days) { day in
                        VStack {
                            Text("\(day.date)")
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 0, alignment: .center)
                            Button("Date") {
                                isShowingDaySelector.toggle()
                            }
                        }
                    }
                }
            }
            .scrollTargetLayout()
            
            
            // TODO: If Daily Plan
        }
        .scrollTargetBehavior(.viewAligned)
        .navigationDestination(for: BreadReadingPlan.Day.self) { day in
            ReadingPlanDayView(day: day)
        }
        .sheet(isPresented: $isShowingDaySelector) {
            if let readingPlan = readingPlanManager.readingPlan {
                ReadingPlanDaySelector(readingPlan: readingPlan)
            }
        }
    }
    
    
}

//#Preview {
//    ReadingPlanView(planId: "bread_2025")
//}
