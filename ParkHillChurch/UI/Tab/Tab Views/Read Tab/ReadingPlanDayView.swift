//
//  ReadingPlanDayView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/4/25.
//

import SwiftUI

struct ReadingPlanDayView: View {
    
    var day: BreadReadingPlan.Day
    var dateButtonPressed: () -> Void = { }
    
    var weekdayString: String {
        day.date.formatted(Date.FormatStyle().weekday(.wide))
    }
    
    var monthYearString: String {
        day.date.formatted(Date.FormatStyle().month(.wide).year())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(Calendar.current.component(.day, from: day.date))")
                    .font(.system(size: 26, weight: .bold))
                    .padding(.trailing)
                
                Button {
                    dateButtonPressed()
                } label: {
                    VStack(alignment: .leading) {
                        Text(monthYearString)
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(.primaryText)
                        Text(weekdayString)
                            .font(.system(size: 15, weight: .thin))
                            .foregroundStyle(.primaryText)
                    }
                }
                
                Spacer()
                
                Button {
                    day.dateCompleted = Date()
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(day.dateCompleted != nil ? .green : .primaryText.opacity(0.5))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//#Preview {
//    ReadingPlanDayView()
//}
