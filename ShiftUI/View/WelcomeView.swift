//
//  WelcomeView.swift
//  ShiftUI
//
//  Created by Zoha on 2/20/21.
//

import SwiftUI

struct WelcomeView: View {
  @State private var difficultyLevel: Level = .medium

  var body: some View {
    NavigationView {
      ZStack {
        Color.offWhite.edgesIgnoringSafeArea(.all)

        VStack {
          Text("Welcome to ShiftUI")
            .font(.largeTitle)
            .fontWeight(.bold)

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
              RoundedRectangle(cornerRadius: 10)
                .neumorphicShadow(height: difficultyLevel == level ? -4 : 4)
                .overlay(Text(level.label))
                .frame(width: 100, height: 60)
                .onTapGesture {
                  difficultyLevel = level
                }
            }
          }

          Spacer()

          NavigationLink(destination: GameView(level: difficultyLevel)){
            Text("Start Game").font(.title)
          }
          .buttonStyle(TileButtonStyle(cornerRadius: 10))
          .frame(height: 60)
          .padding(.horizontal, 50)

          Spacer()

        }
      }
      .foregroundColor(.grayText)
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
