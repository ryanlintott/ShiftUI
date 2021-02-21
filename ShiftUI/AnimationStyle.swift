//
//  AnimationStyles.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

enum AnimationStyle {
    case neumorphic, instant, textFade
    
    static let durationMultiplier: Double = 1
    
    var duration: Double {
        switch self {
        case .instant: return 0.01 * Self.durationMultiplier
        case .textFade: return 1 * Self.durationMultiplier
        case .neumorphic: return 0.5 * Self.durationMultiplier
        }
    }
    
    var animation: Animation {
        switch self {
        default: return .easeInOut(duration: self.duration)
        }
    }
}
