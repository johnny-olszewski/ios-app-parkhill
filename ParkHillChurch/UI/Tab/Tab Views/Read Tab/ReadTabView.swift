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
    
    @State private var selectedSection: Section = .bread
    @State private var debugProvider: Bool = true
    
    let viewModel: ReadTabViewModel = .init()
    
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
            
            SectionPicker
            
            switch selectedSection {
            case .bread:
                ReadingPlanView(viewModel: generateViewModel())
                    .ignoresSafeArea(edges: [.bottom])
                
            case .read:
                Text("Read Section")
            }
        }
    }
    
    @ViewBuilder
    var SectionPicker: some View {
        HStack {
            ForEach(viewModel.availableSections) { section in
                pickerButton(for: section)
            }
        }
    }
    
    @ViewBuilder
    func pickerButton(for section: Section) -> some View {
        Button {
            selectedSection = section
        } label: {
            ZStack {
                Capsule()
                    .fill(selectedSection == section ? Color.primaryText : .clear)
                    .stroke(Color.primaryText, lineWidth: 1)
                    .frame(width: 60, height: 24)
                
                Text(section.rawValue.uppercased())
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(selectedSection == section ? Color.primaryBackground : .primaryText)
            }
        }
    }
    
    private func generateViewModel() -> ReadingPlanViewModel {
        let provider: ReadingPlanProviding
        #if DEBUG
        provider = debugAppState.isUsingDebugReadingPlanProvider ? DEBUGReadingPlanManager() : ReadingPlanManager()
        #else
        provider = ReadingPlanManager()
        #endif
        
        return ReadingPlanViewModel(planId: ParkHillSharedConstants.ReadingPlan.bread2025Id, provider: provider)
    }
}

#Preview {
    ReadTabView()
}
