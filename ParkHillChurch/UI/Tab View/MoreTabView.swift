//
//  HomeTab.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/30/25.
//

import SwiftUI

struct MoreTabView: View {
    var body: some View {
        NavigationStack {
            Text("More")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "person.circle")
                            .font(.system(size: 18))
                    }
                }
        }
    }
}

#Preview {
    MoreTabView()
}
