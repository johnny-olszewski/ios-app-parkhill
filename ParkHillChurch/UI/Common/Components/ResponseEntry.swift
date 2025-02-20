//
//  ResponseEntry.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

struct ResponseEntry: View {
    
    @Binding var response: String
    
    var body: some View {
        TextEditor(text: $response)
            .padding()
            .padding(.bottom, 16)
            .scrollContentBackground(.hidden)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.brown.opacity(0.7))
            }
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 16))
                    .foregroundStyle(.brown.opacity(0.7))
                    .padding()
            }
    }
}