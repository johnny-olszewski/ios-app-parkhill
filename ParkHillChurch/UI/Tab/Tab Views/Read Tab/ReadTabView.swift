//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct ReadTabView: View {
    
    #if DEBUG
    @Environment(\.debugAppState) private var debugAppState
    #endif
    
    @Environment(\.modelContext) var modelContext
    @State private var debugProvider: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.primaryBackground
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
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
            ReadingPlanView(readingPlanManager: generateReadingPlanManager())
                .ignoresSafeArea(edges: [.bottom])
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
    ReadTabView()
}
