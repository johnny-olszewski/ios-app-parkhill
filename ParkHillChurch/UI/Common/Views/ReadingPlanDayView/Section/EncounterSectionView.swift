//
//  EncounterSectionView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/20/25.
//


import SwiftUI

struct EncounterSectionView: View {
    
    var response: Binding<String>?
    
    var body: some View {
        Text("Encounter Section")
        
        if let response {
            ResponseEntry(response: response)
        }
    }
}