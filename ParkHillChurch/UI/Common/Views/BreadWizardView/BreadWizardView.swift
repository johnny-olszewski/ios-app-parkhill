//
//  BreadWizard.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/25/25.
//

import SwiftUI

struct BreadWizardView: View {
    
    @State var breatheResponse: String = ""
    @State var selectedStep: BreadStep? = .breathe
    
    var day: BreadReadingPlan.Day
    
    var body: some View {
        
        ZStack {
            Color.primaryBackground.edgesIgnoringSafeArea(.all)
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack {
                        ForEach(BreadStep.allCases, id: \.self) { type in
                            type.wizardView
                                .id(type)
                                .padding(.top)
                                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                        }
                    }
                    .scrollTargetLayout()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .scrollPosition(id: $selectedStep)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaInset(edge: .top) {
                header
            }
        }
    }
}

extension BreadWizardView {
    
    var header: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                }
                
                VStack {
                    Text("\(day.date.formatted(Date.FormatStyle().day(.twoDigits).month(.wide)))")
                        .font(.title.lowercaseSmallCaps())
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Day \(day.dayOfPlan)")
                        .font(.caption)
                        .foregroundStyle(.primaryText.opacity(0.7))
                }
                
                Spacer()
                
                Button {
                    day.toggleDate()
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(day.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
                        .font(.system(size: 24))
                }
            }
            .padding(.horizontal)
            
            BreadStepSelector(selectedStep: $selectedStep)
        }
    }
}

#Preview {
    
    @Previewable @State var breatheResponse: String = ""
    
    let manager: ReadingPlanManager = .init(planId: BreadReadingPlan.bread2025Id)
    let day: BreadReadingPlan.Day? = manager.getDay(0)
    
    if let day {
        BreadWizardView(day: day)
    }
}


