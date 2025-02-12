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
    @State var selectedDayOfPlan: Int? = 0
    
    var selectedDay: BreadReadingPlan.Day? {
        guard let selectedDayOfPlan else { return nil }
        
        return readingPlanManager.getDay(selectedDayOfPlan)
    }
    
    init(readingPlanManager: ReadingPlanManager) {
        self.readingPlanManager = readingPlanManager
        
        self.selectedDayOfPlan = 2
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { proxy in
                LazyHStack {
                    if let days = readingPlanManager.getAllDays() {
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
                .onChange(of: selectedDayOfPlan) { oldValue, newValue in
                    print("OLD: \(oldValue)\tNEW: \(newValue)")
                }
            }
        }
        .scrollPosition(id: $selectedDayOfPlan)
        .safeAreaInset(edge: .top) {
            header
                .padding()
        }
        .scrollTargetBehavior(.viewAligned)
        .sheet(isPresented: $isShowingDaySelector) {
            if let readingPlan = readingPlanManager.readingPlan {
                ReadingPlanDaySelector(readingPlan: readingPlan, isPresented: $isShowingDaySelector, selectedDay: $selectedDayOfPlan)
            }
        }
    }
}

extension ReadingPlanView {
    
    @ViewBuilder
    private var header: some View {
        if let visibleDay = selectedDay, let selectedDayOfPlan {
            Button {
                isShowingDaySelector.toggle()
            } label: {
                HStack {
                    DateLabel(value: selectedDayOfPlan)
                        .animation(.easeInOut, value: selectedDayOfPlan)
                        .font(.system(size: 26, weight: .bold))
                        .padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text(visibleDay.date.formatted(Date.FormatStyle().weekday(.wide)))
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(.primaryText)
                        Text(visibleDay.date.formatted(Date.FormatStyle().month(.wide).year()))
                            .font(.system(size: 15, weight: .thin))
                            .foregroundStyle(.primaryText)
                    }
                    
                    Spacer()
                    
                    Button {
                        visibleDay.dateCompleted = Date()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(visibleDay.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
                    }
                }
            }
        }
    }
}

struct DateLabel: View, Animatable {
    
    var value: Int
    
    var animatableData: Double {
        get { Double(value) }
        set { value = Int(newValue) }
    }
    
    var body: some View {
        Text("\(value)")
    }
}

//#Preview {
//    ReadingPlanView(planId: "bread_2025")
//}
