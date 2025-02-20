//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct BreadTabView: View {
    
#if DEBUG
    @Environment(\.debugAppState) private var debugAppState
#endif
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ReadingPlanView(readingPlanManager: generateReadingPlanManager())
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "person.circle")
                            .font(.system(size: 18))
                    }
                }
        }
    }
    
    @ViewBuilder var content: some View {
        
        VStack {
            
        }
    }
    
    private func generateReadingPlanManager() -> ReadingPlanManager {
        
#if DEBUG
        return  DEBUGReadingPlanManager(
            planId: ParkHillSharedConstants.ReadingPlan.bread2025Id,
            modelContext: modelContext,
            shouldUseDebugReadingPlanManager: debugAppState.isUsingDebugReadingPlanProvider
        )
#else
        return  ReadingPlanManager(planId: ParkHillSharedConstants.ReadingPlan.bread2025Id, modelContext: modelContext)
#endif
    }
}

#Preview {
    BreadTabView()
}
