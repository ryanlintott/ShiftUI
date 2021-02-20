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

  func neumorphicShadowSelected() -> some View {
    let shape1 = self
    let shape2 = self
    let shape3 = self
    let shape4 = self

    return self
      .fill(Color.offWhite)
      .overlay(
        shape1
          .stroke(Color.gray, lineWidth: 4)
          .blur(radius: 4)
          .offset(x: 2, y: 2)
          .mask(
            shape2
              .fill(LinearGradient(Color.black, Color.clear))
          )
      )
      .overlay(
        shape3
          .stroke(Color.white, lineWidth: 8)
          .blur(radius: 4)
          .offset(x: -2, y: -2)
          .mask(
            shape4
              .fill(LinearGradient(Color.clear, Color.black))
          )
      )
  }

  @ViewBuilder
  func neumorphic(for isPressed: Bool) -> some View {
    if isPressed {
      self.neumorphicShadowSelected()
    } else {
      self.neumorphicShadow()
    }
  }
}
