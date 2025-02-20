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
        if let day = selectedDay {
            VStack {
                header
                    .padding(.horizontal)
                
                ReadingPlanDayView(day: day) {
                    isShowingDaySelector.toggle()
                }
            }
            .sheet(isPresented: $isShowingDaySelector) {
                if let readingPlan = readingPlanManager.readingPlan {
                    ReadingPlanDaySelectorView(readingPlan: readingPlan, isPresented: $isShowingDaySelector, selectedDay: $selectedDayOfPlan)
                }
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
                        
                        VStack(alignment: .leading) {
                            Text(visibleDay.date.formatted(Date.FormatStyle().weekday(.wide)))
                                .font(.system(size: 18, weight: .light).lowercaseSmallCaps())
                                .foregroundStyle(.primaryText)
                            Text(visibleDay.date.formatted(Date.FormatStyle().month(.wide).year()))
                                .font(.system(size: 20, weight: .thin).lowercaseSmallCaps())
                                .foregroundStyle(.primaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        visibleDay.dateCompleted = visibleDay.dateCompleted != nil ? Date() : nil
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(visibleDay.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
                            .font(.system(size: 24))
                    }
                    
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
