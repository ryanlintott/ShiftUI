//
//  ResultView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct ResultView: View {
  @EnvironmentObject var viewManager: ViewManager
  let score: Int
  
  var body: some View {
    VStack {
      Spacer()
      
      Text("Winner Winner\nChicken Dinner...!")
        .font(.largeTitle)
        .fontWeight(.medium)
        .multilineTextAlignment(.center)
        .animation(AnimationStyle.textFade.animation)
      
      Spacer()
      
      SuccessView(score: score)
      
      Spacer()
    }
    .padding()
  }
}

struct ResultView_Previews: PreviewProvider {
  static var previews: some View {
    ResultView(score: 343)
  }
}
