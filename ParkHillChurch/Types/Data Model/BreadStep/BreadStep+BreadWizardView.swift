//
//  BreadStep+BreadWizard.swift
//  ParkHillChurch
//
//  Created by Johnny O on 2/26/25.
//

import SwiftUI

extension BreadStep {
    
    var wizardView: some View { BreadWizardStepView(title: self.rawValue, prompt: prompt) }
}
