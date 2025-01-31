//
//  ProfileButton.swift
//  ParkHillChurch
//
//  Created by Johnny O on 1/31/25.
//

import SwiftUI

struct ProfileButton: View {
    
    let onPressAction: () -> Void
    
    var body: some View {
        Button {
            onPressAction()
        } label: {
            Image(systemName: "person.circle")
                .font(.system(size: 18))
                .foregroundStyle(Color.primaryText)
        }
    }
}

#Preview {
    ProfileButton(onPressAction: {})
}
