//
//  DEBUGContextManager.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/21/25.
//

import Foundation

class DEBUGContextManager: ObservableObject {
    
    static var shared = DEBUGContextManager()
    
    var isUsingDebugReadingPlanProvider: Bool = false
    
    private init() {}
}
