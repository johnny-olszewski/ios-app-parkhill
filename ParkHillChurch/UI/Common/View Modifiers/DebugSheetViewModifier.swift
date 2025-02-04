//
//  DebugSheetModifier.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//


import SwiftUI
import SwiftData

struct DebugSheetViewModifier<SheetContent: View>: ViewModifier {
    @ViewBuilder let sheetContent: () -> SheetContent
    @State private var isSheetPresented = false

    func body(content: Content) -> some View {
        #if DEBUG
        content
            .overlay(alignment: .bottomTrailing) {
                Button {
                    isSheetPresented = true
                } label: {
                    Image(systemName: "ant.circle")
                        .font(.system(size: 32))
                        .padding(8)
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                sheetContent()
            }
        #else
        content
        #endif
    }
}

extension View {
    func debugSheet<SheetContent: View>(@ViewBuilder sheetContent: @escaping () -> SheetContent) -> some View {
        self.modifier(DebugSheetViewModifier(sheetContent: sheetContent))
    }
}
