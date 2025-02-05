//
//  ReadingPlanDayView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//

import SwiftUI

struct ReadingPlanDayView: View {
    
    var day: BreadPlan.Day
    
    var body: some View {
        HStack {
            VStack {
                Text(day.id)
                Text("\(day.date.formatted(date: .numeric, time: .omitted))")
                Text(day.passages.description)
            }
            
            Button {
                day.isCompleted.toggle()
            } label: {
                Image(systemName: "checkmark")
                    .foregroundStyle(.primaryText)
                    .opacity(day.isCompleted ? 1 : 0.5)
            }
        }
    }
}

//#Preview {
//    ReadingPlanDayView()
//}
