//
//  ReadingPlanDayView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//

import SwiftUI

struct ReadingPlanDayView: View {
    
    var day: BreadDay
    
    var body: some View {
        HStack {
            VStack {
                Text("\(day.date.formatted(date: .numeric, time: .omitted))")
                Text(day.passages.description)
            }
            
            Button {
                
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
