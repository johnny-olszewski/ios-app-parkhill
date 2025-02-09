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
            ReadingPlanView(viewModel: generateViewModel())
                .ignoresSafeArea(edges: [.bottom])
        }
    }
    
    private func generateViewModel() -> ReadingPlanViewModel {
        let readingPlanManager: ReadingPlanManager
        #if DEBUG
        readingPlanManager =  DEBUGReadingPlanManager(shouldUseDebugReadingPlanManager: debugAppState.isUsingDebugReadingPlanProvider)
        #else
        readingPlanManager = ReadingPlanManager()
        #endif
        
        return ReadingPlanViewModel(planId: ParkHillSharedConstants.ReadingPlan.bread2025Id, readingPlanManager: readingPlanManager)
    }
}

#Preview {
    ReadTabView()
}
