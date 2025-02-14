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
                            .border(.red)
                            .background(Color.yellow)
                            .id(day.dayOfPlan)
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 0, alignment: .center)
                        }
                    }
                }
                .scrollTargetLayout()
            }
        }
        .scrollPosition(id: $selectedDayOfPlan)
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(.primaryBackground, for: .navigationBar)
        .safeAreaInset(edge: .top) {
            header
                .padding(.horizontal)
                .border(.blue)        }
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
                    
                    HStack {
                        ValueLabel(value: selectedDayOfPlan)
                            .animation(.easeInOut, value: selectedDayOfPlan)
                            .font(.system(size: 42, weight: .bold))
                            .padding(.trailing, 8)
                            .foregroundStyle(.primaryText)
                            .monospacedDigit() // ✅ Ensures numbers take up equal width
                            .frame(width: 65, alignment: .trailing) // ✅ Adjust width to fit expected digits
                            .border(.black)
                        
                        VStack(alignment: .leading) {
                            Text(visibleDay.date.formatted(Date.FormatStyle().weekday(.wide)))
                                .font(.system(size: 18, weight: .light).lowercaseSmallCaps())
                                .foregroundStyle(.primaryText)
                            Text(visibleDay.date.formatted(Date.FormatStyle().month(.wide).year()))
                                .font(.system(size: 20, weight: .thin).lowercaseSmallCaps())
                                .foregroundStyle(.primaryText)
                        }
                        
                        
                        
                        Button {
                            visibleDay.dateCompleted = Date()
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(visibleDay.dateCompleted != nil ? .primaryText.opacity(0.5) : .green)
                                .font(.system(size: 24))
                        }
                    }
                    .padding(.trailing)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        
                        chevronButton(-1)
                        
                        chevronButton(1)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func chevronButton(_ increment: Int) -> some View {
        Button {
            self.selectedDayOfPlan? += increment
        } label: {
            Image(systemName: increment < 0 ? "chevron.left" : "chevron.right")
                .font(.system(size: 20))
                .foregroundStyle(.primaryText)
        }
    }
}



//#Preview {
//    ReadingPlanView(planId: "bread_2025")
//}
