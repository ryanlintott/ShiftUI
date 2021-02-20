//
//  NeumorphicShadow.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

extension Shape {
  func neumorphicShadow() -> some View {
    self
      .fill(Color.offWhite)
      .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
      .shadow(color: Color.white.opacity(0.7), radius: 5, x: -5, y: -5)
  }
}
