//
//  NeumorphicButton.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct NeumorphicButtonStyle: ButtonStyle {
  let height: CGFloat
  let pressedHeight: CGFloat
  
  init(height: CGFloat = 5, pressedHeight: CGFloat = -4) {
    self.height = height
    self.pressedHeight = pressedHeight
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
        .neumorphicShadow(height: configuration.isPressed ? pressedHeight : height)
  }
}

struct NeumorphicButton_Previews: PreviewProvider {
    static var previews: some View {
      Button {
        // do nothing
      } label: {
        Image(systemName: "xmark")
          .font(Font.title.weight(.black))
      }
      .buttonStyle(NeumorphicButtonStyle())
    }
}
