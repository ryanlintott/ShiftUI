//
//  AppIconView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct AppIcon: View {
  let size: CGFloat = 1024
  let roundingPercentage: CGFloat = 0.2237
  var cornerRadius: CGFloat {
    size * roundingPercentage
  }
  
  var shape: some InsettableShape {
    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
  }
  
  var body: some View {
    ZStack {
      shape
//        .inset(by: size * 0.09)
        .neumorphicShadow(height: -20)
      
      Image(systemName: "shift")
        .font(.system(size: 540))
        .foregroundColor(.grayText)
        .neumorphicShadow(height: 10)
    }
    .frame(width: size, height: size)
    .background(Color.offWhite.edgesIgnoringSafeArea(.all))
    
  }
}

struct AppIcon_Previews: PreviewProvider {
  static var previews: some View {
    AppIcon()
      .previewLayout(.sizeThatFits)
  }
}
