//
//  WelcomeView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct WelcomeView: View {
  @EnvironmentObject var viewManager: ViewManager
  @Binding var difficultyLevel: Level

  var body: some View {
    VStack {
      HStack {
        Text("Look again it's")
        Text("ShiftUI").fontWeight(.bold)
        Text("not SwiftUI 👻")
      }
      .font(.caption)
      
      Spacer()
      
      Text("Select difficulty level")
        .font(.title)
      
      HStack(spacing: 20) {
        ForEach(Level.allCases) { level in
          Text(level.label)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 10)
                .neumorphicShadow(height: difficultyLevel == level ? -4 : 4)
            )
            .onTapGesture {
              difficultyLevel = level
            }
        }
      }
      
      Spacer()
      
      Button {
        viewManager.activeView = .game
      } label: {
        Text("Start Game")
          .font(.title)
      }
      .buttonStyle(TileButtonStyle(cornerRadius: 10))
      .frame(height: 60)
      .padding(.horizontal, 50)
      
      Spacer()
      
    }
    .padding()
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(difficultyLevel: .constant(.medium))
  }
}
