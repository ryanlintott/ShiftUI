//
//  ShiftTile.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-20.
//

import SwiftUI

struct ShiftTile<Content: View>: View {
  @Binding var isPressed: Bool
  let cornerRadius: CGFloat
  let content: () -> Content
  
//  init(isPressed: Binding<Bool>, cornerRadius: CGFloat, @ViewBuilder content: @escaping)
    
  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .neumorphicShadow(height: isPressed ? -4 : 4)
      .overlay(content())
  }
}

struct ShiftTile_Previews: PreviewProvider {
  struct PreviewData: View {
    @State private var isPressed: Bool = false
    
    var body: some View {
      ShiftTile(isPressed: $isPressed, cornerRadius: 5) {
        Text("Hello")
          .foregroundColor(.grayText)
          .bold()
          .neumorphicShadow(height: 1)
      }
      .offset(y: isPressed ? 100 : 0)
      .frame(width: 100, height: 100)
      .onTapGesture {
        withAnimation {
          isPressed.toggle()
        }
      }
    }
  }
  
  static var previews: some View {
    Color.offWhite.edgesIgnoringSafeArea(.all)
      .overlay(
        PreviewData()
      )
  }
}
