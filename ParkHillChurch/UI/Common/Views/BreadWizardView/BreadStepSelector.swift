//
//  BreadWizardView 2.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/26/25.
//


import SwiftUI

struct BreadStepSelector: View {
    
    @Binding var selectedStep: BreadStep?
    
    @State private var labelWidths: [BreadStep: CGFloat] = [:]
    @State private var labelFrames: [BreadStep: CGRect] = [:]
    
    // The indicator's width matches the selected label
    var indicatorWidth: CGFloat {
        guard let selectedStep else { return 0 }
        return labelWidths[selectedStep] ?? 0
    }
    
    // We calculate how far to shift the indicator so its center is under the label's center
    private var indicatorOffsetX: CGFloat {
        guard let selectedStep,
              let frame = labelFrames[selectedStep] else {
            return 0
        }
        // Center alignment under the label
        let centerX = frame.midX
        return centerX - (indicatorWidth / 2)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 24) {
                ForEach(BreadStep.allCases, id: \.self) { type in
                    Button {
                        withAnimation {
                            selectedStep = type
                        }
                    } label: {
                        Text(type.rawValue)
                            .font(.caption)
                            .foregroundColor(.primaryText.opacity(selectedStep == type ? 1 : 0.7))
                    }
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let width = geometry.size.width
                                    let frameInStack = geometry.frame(in: .named("labelStack"))
                                    labelWidths[type] = width
                                    labelFrames[type] = frameInStack
                                }
                        }
                    }
                }
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 2)
                // Use alignment: .leading so x=0 is the left edge
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.primaryText)
                        .frame(width: indicatorWidth, height: 2)
                        .offset(x: indicatorOffsetX)
                }
        }
        // Name the coordinate space for measuring label frames
        .coordinateSpace(name: "labelStack")
    }
}

#Preview {
    
    @Previewable @State var selectedStep: BreadStep? = .breathe
    
    BreadStepSelector(selectedStep: $selectedStep)
}
