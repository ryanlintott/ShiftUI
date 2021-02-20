//
//  NeumorphicShadow.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

extension Shape {
  func neumorphicShadow(color: Color = .offWhite, height: CGFloat = 5) -> some View {
    self
      .fill(color)
      .overlay(
          ZStack {
            self
              .stroke(Color.black.opacity(0.43), lineWidth: height.magnitude)
              .blur(radius: height.magnitude)
              .offset(x: -height / 2, y: -height / 2)
              .mask(
                self
                  .fill(LinearGradient(Color.black, Color.clear))
              )
            
            self
              .stroke(Color.white, lineWidth: height.magnitude * 2)
              .blur(radius: height.magnitude)
              .offset(x: height / 2, y: height / 2)
              .mask(
                self
                  .fill(LinearGradient(Color.clear, Color.black))
              )
          }
          .opacity(height < 0 ? 1 : 0)
      )
      .shadow(color: Color.black.opacity(0.2).opacity(height > 0 ? 1 : 0), radius: height.magnitude, x: height, y: height)
      .shadow(color: Color.white.opacity(0.7).opacity(height > 0 ? 1 : 0), radius: height.magnitude, x: -height, y: -height)
  }
}

extension View {
  func neumorphicShadow(height: CGFloat = 5) -> some View {
    self
      .overlay(
        ZStack {
          Color.black.opacity(0.1)
            .mask(
              Color.white
                .overlay(
                  Color.black
                    .mask(
                      self
                        .offset(x: -height * 1.5, y: -height * 1.5)
                        .blur(radius: height.magnitude)
                    )
                )
                .drawingGroup()
                .luminanceToAlpha()
            )
            .blendMode(.darken)
          
          Color.white.opacity(0.4)
            .mask(
              Color.white
                .overlay(
                  Color.black
                    .mask(
                      self
                        .offset(x: height * 1.5, y: height * 1.5)
                        .blur(radius: height.magnitude)
                    )
                )
                .drawingGroup()
                .luminanceToAlpha()
            )
            .blendMode(.screen)
        }
        .mask(self)
        .opacity(height < 0 ? 1 : 0)
      )
      .shadow(color: Color.black.opacity(0.2).opacity(height > 1 ? 1 : 0), radius: height.magnitude, x: height, y: height)
      .shadow(color: Color.white.opacity(0.7).opacity(height > 1 ? 1 : 0), radius: height.magnitude, x: -height, y: -height)
  }
}

struct NeumorphicShadow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {

      Circle()
        .fill(Color.offWhite)
        .neumorphicShadow(height: -10)
        .padding(50)
      
      Text("Hello World")
        .font(.title)
        .bold()
        .foregroundColor(Color.grayText)
        .neumorphicShadow(height: 2)
      
      Text("Hello World")
        .font(.title)
        .bold()
        .foregroundColor(Color.grayText)
        .neumorphicShadow(height: -0.5)
      
      Circle()
        .neumorphicShadow(height: -10)
        .padding(50)
      
    }
    .background(Color.offWhite.edgesIgnoringSafeArea(.all))
  }
}

