//
//  DEBUGAppStateView.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//

import SwiftUI

#if DEBUG

struct DEBUGAppStateView: View {
    
    @Binding var debugAppState: DEBUGAppState
    
    var body: some View {
        VStack {
            Toggle("Debug Reading Plan Provider", isOn: $debugAppState.isUsingDebugReadingPlanProvider)
                .padding()
        }
    }
}

#endif
