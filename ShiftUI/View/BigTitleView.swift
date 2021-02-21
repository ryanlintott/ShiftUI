//
//  BigTitleView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct BigTitleView: View {
  let text: String
  
  var body: some View {
    Text("ShiftUI")
      .font(.system(size: 60))
      .fontWeight(.black)
      .minimumScaleFactor(0.5)
      .neumorphicShadow(height: 3)
  }
}

struct BigTitleView_Previews: PreviewProvider {
  static var previews: some View {
    BigTitleView(text: "ShiftUI")
  }
}
