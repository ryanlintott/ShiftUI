//
//  SuccessView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct SuccessView: View {
  @State private var scale: CGFloat = 0.8
  @State private var opacity: Double = 1
  
  @State private var isShowingText: Bool = false
  @State private var isNeumorphic: Bool = false
  
  let score: Int
  
  var body: some View {
    VStack {
      Text("Your score")
      
      Text("\(score)")
        .font(.largeTitle)
        .fontWeight(.medium)
        .foregroundColor(.pink)
    }
    .frame(width: 200, height: 200)
    .opacity(isShowingText ? 1 : 0)
    .background(
      Circle().neumorphicShadow(isActive: isNeumorphic)
    )
    .background(
      Circle()
        .neumorphicShadow(isActive: isNeumorphic)
        .scaleEffect(scale)
        .opacity(opacity)
    )
    .onAppear {
      withAnimation(AnimationStyle.textFade.animation) {
        isShowingText = true
      }
      withAnimation(AnimationStyle.neumorphic.animation.delay(AnimationStyle.textFade.duration / 2)) {
        isNeumorphic = true
      }
      withAnimation(
        Animation
          .easeIn(duration: 2)
          .repeatForever(autoreverses: false)
          .delay(AnimationStyle.textFade.duration / 2)
      ) {
        opacity = 0.0
        scale = 3
      }
    }
  }
}

struct SuccessView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.offWhite.edgesIgnoringSafeArea(.all)
      SuccessView(score: 232)
    }
  }
}
