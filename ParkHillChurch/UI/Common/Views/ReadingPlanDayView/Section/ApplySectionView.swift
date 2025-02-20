//
//  ApplySectionView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

struct ApplySectionView: View {
    
    var response: Binding<String>?

    var body: some View {
        Text("Apply Section")
        
        if let response {
            ResponseEntry(response: response)
        }
    }
}