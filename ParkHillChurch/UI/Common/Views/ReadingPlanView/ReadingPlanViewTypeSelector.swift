//
//  ReadingPlanViewTypeSelector.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/25/25.
//

import SwiftUI

struct ReadingPlanViewTypeSelector: View {
    
    @Binding var selectedViewType: ReadingPlanView.ViewType
    
    var body: some View {
        HStack(spacing: 16) {
            
            viewTypeSelectorButton(for: .calendar, imageName: "calendar")
            
            viewTypeSelectorButton(for: .list, imageName: "list.bullet")
        }
    }
    
    private func viewTypeSelectorButton(for viewType: ReadingPlanView.ViewType, imageName: String) -> some View {
        Button {
            withAnimation {
                selectedViewType = viewType
            }
        } label: {
            Image(systemName: imageName)
                .font(.system(size: 24))
                .foregroundStyle(selectedViewType == viewType ? .black : .black.opacity(0.5))
        }
    }
}
