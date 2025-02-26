//
//  BreadStepView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/26/25.
//


import SwiftUI

struct BreadWizardStepView: View {
    
    var response: Binding<String>?
    
    var title: String
    var prompt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
//            Text(title)
//                .font(.system(size: 44, weight: .bold).lowercaseSmallCaps())
//                .foregroundStyle(.primaryText)
            Text(prompt)
                .font(.system(size: 16).italic())
                .foregroundStyle(.primaryText.opacity(0.7))
        }
        .padding(.horizontal)
    }
}
