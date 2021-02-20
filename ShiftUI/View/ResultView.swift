//
//  ResultView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct ResultView: View {
    let score: Int

    var body: some View {
      ZStack {
        Color.offWhite.edgesIgnoringSafeArea(.all)

        VStack {
          Spacer()

          Text("Winner Winner\nChicken Dinner...!")
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)

          Spacer()

          SuccessView(score: score)

          Spacer()
        }
      }
      .foregroundColor(.grayText)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(score: 343)
    }
}
