//
//  DevoteSectionView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

struct DevoteSectionView: View {
    
    var response: Binding<String>?

    var body: some View {
        Text("Devote Section")
        
        if let response {
            ResponseEntry(response: response)
        }
    }
}