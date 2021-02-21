//
//  NeumorphicButton.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct NeumorphicButton<Content: View>: View {
  let height: CGFloat
  let pressedHeight: CGFloat
  let action: () -> Void
  let label: () -> Content
  
  @State private var isShowingButton: Bool = false

  var body: some View {
    Button(action: action) {
      label()
        .opacity(isShowingButton ? 1 : 0)
    }
    .buttonStyle(NeumorphicButtonStyle(isActive: isShowingButton, height: height, pressedHeight: pressedHeight))
    .onAppear {
      withAnimation(AnimationStyle.neumorphic.animation) {
        isShowingButton = true
      }
    }
    .onDisappear {
      withAnimation(AnimationStyle.neumorphic.animation) {
        isShowingButton = true
      }
    }
  }
}

struct NeumorphicButtonStyle: ButtonStyle {
  let isActive: Bool
  let height: CGFloat
  let pressedHeight: CGFloat
  
  init(isActive: Bool = true, height: CGFloat = 5, pressedHeight: CGFloat = -4) {
    self.isActive = isActive
    self.height = height
    self.pressedHeight = pressedHeight
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .neumorphicShadow(isActive: isActive, height: configuration.isPressed ? pressedHeight : height)
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
