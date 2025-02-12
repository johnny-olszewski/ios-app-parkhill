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
    @State var selectedDay: Int? = 0
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
        
        self.selectedDay = 2
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                LazyHStack {
                    if let days = readingPlanManager.getDays() {
                        ForEach(days) { day in
                            ReadingPlanDayView(day: day) {
                                isShowingDaySelector.toggle()
                            }
                            .id(day.dayOfPlan)
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 0, alignment: .center)
                        }
                    }
                }
                .scrollTargetLayout()
                .onChange(of: selectedDay) { oldValue, newValue in
                    print("OLD: \(oldValue)\tNEW: \(newValue)")
                }
            }
        }
        .scrollPosition(id: $selectedDay)
        .safeAreaInset(edge: .top) {
            header
            .padding()
            
            HStack {
                Button("5") {
                    withAnimation {
                        selectedDay = 5
                    }
                }
                Button("10") {
                    selectedDay = 10
                }
                Button("20") {
                    withAnimation {
                        selectedDay = 20
                    }
                }
            }
        }
        .scrollTargetBehavior(.viewAligned)
        .sheet(isPresented: $isShowingDaySelector) {
            if let readingPlan = readingPlanManager.readingPlan {
                ReadingPlanDaySelector(readingPlan: readingPlan, isPresented: $isShowingDaySelector, selectedDay: $selectedDay)
            }
        }
    }
}

extension ReadingPlanView {
    
    private var header: some View {
        HStack {
            
            
            Button {
                isShowingDaySelector.toggle()
            } label: {
                Text("\(selectedDay)")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.trailing)
            }
        }
    }
}

//#Preview {
//    ReadingPlanView(planId: "bread_2025")
//}
