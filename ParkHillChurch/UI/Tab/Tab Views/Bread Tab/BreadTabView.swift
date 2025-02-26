//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct BreadTabView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        ReadingPlanView(
            readingPlanManager: ManagerFactory.generateReadingPlanManager(
                planId: BreadReadingPlan.bread2025Id,
                modelContext: modelContext
            )
        )
    }
    
    @ViewBuilder var content: some View {
        
        VStack {
            
        }
    }
}

#Preview {
    BreadTabView()
}
