//
//  DEBUGAppState.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/3/25.
//

#if DEBUG

import Foundation
import SwiftUI

struct DEBUGAppState {
    var isUsingDebugReadingPlanProvider: Bool = false
}

struct DEBUGAppStateKey: EnvironmentKey {
    static let defaultValue = DEBUGAppState() // Default value
}

extension EnvironmentValues {
    var debugAppState: DEBUGAppState {
        get { self[DEBUGAppStateKey.self] }
        set { self[DEBUGAppStateKey.self] = newValue }
    }
}

#endif
