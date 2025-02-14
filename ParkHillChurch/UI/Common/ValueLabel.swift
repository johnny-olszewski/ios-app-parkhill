//
//  ValueLabel.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/11/25.
//


import SwiftUI
import SwiftData

struct ValueLabel: View, Animatable {
    
    var value: Int
    
    var animatableData: Double {
        get { Double(value) }
        set { value = Int(newValue) }
    }
    
    var body: some View {
        Text("\(value)")
    }
}