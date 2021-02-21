//
//  ContentView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewManager: ViewManager = ViewManager()
  @State private var difficultyLevel: Level = .medium
  
  var body: some View {
    ZStack {
      Color.offWhite.edgesIgnoringSafeArea(.all)
      
      VStack {
        BigTitleView(text: "ShiftUI")

        switch viewManager.activeView {
        case .home:
          WelcomeView(difficultyLevel: $difficultyLevel)
        case .game:
          GameView(level: difficultyLevel)
        }
      }
    }
    .overlay(
      Group {
        if viewManager.activeView != .home {
          Button {
            viewManager.activeView = .home
          } label: {
            Image(systemName: "xmark")
              .font(Font.title.weight(.black))
          }
          .buttonStyle(NeumorphicButtonStyle(height: 2, pressedHeight: -2))
          .padding(10)
        }
      }
      
      , alignment: .topTrailing
    )
    .foregroundColor(.grayText)
    .environmentObject(viewManager)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
