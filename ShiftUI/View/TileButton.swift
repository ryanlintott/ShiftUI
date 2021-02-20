//
//  TileView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct TileButton: View {
  let data: Int
  let action: () -> Void

  var body: some View {
    Button(action: action) {
        Text("\(data)")
    }
    .buttonStyle(TileButtonStyle(cornerRadius: 8))
  }
}

struct TileButtonStyle: ButtonStyle {
  let cornerRadius: CGFloat

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      Group {
        if configuration.isPressed {
          RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.offWhite)
            .overlay(
              RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: 4)
                .blur(radius: 4)
                .offset(x: 2, y: 2)
                .mask(
                  RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(Color.black, Color.clear))
                )
            )
            .overlay(
              RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.white, lineWidth: 8)
                .blur(radius: 4)
                .offset(x: -2, y: -2)
                .mask(
                  RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(Color.clear, Color.black))
                )
            )
        } else {
          RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.offWhite)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 5, x: -5, y: -5)
        }
      }

      configuration.label
    }
  }
}

struct TileView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.offWhite.edgesIgnoringSafeArea(.all)

      TileButton(data: 2, action: {})
        .frame(width: 50, height: 50)
    }
  }
}
