//
//  ContentView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct GameView: View {
  @EnvironmentObject var viewManager: ViewManager
  @StateObject var board = ShiftBoard()
  @State private var isShowingResult = false
  @State private var isShowingBoard = false
  
  let level: Level

  var body: some View {
    ZStack {
      Color.clear
      
      if isShowingResult {
        ResultView(score: board.moves)
      } else {
        VStack {
          HStack {
            Text("Moves:")
            Spacer()
            Text("\(board.moves)")
              .animation(nil)
          }
          .font(.title)
          .padding(.horizontal)
          .padding(.vertical, 5)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .neumorphicShadow(height: 2)
          )
          .padding(.horizontal, 30)
          .padding(.all, 10)
          
          GeometryReader { proxy in
            if isShowingBoard {
              BoardView(availableSize: proxy.size)
                .environmentObject(board)
            }
          }
        }
        .padding()
      }
    }
    .onAppear(perform: setupBoard)
    .onChange(of: board.isSolved) { isSolved in
      if isSolved {
        showResults()
      }
    }
  }
  
  func setupBoard() {
    board.initBoard(level: level)
    board.shuffleBoard()
    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationStyle.neumorphic.duration) {
      isShowingBoard = true
    }
  }
  
  func showResults() {
    withAnimation(AnimationStyle.neumorphic.animation.delay(1)) {
      isShowingBoard = false
    }
    withAnimation(AnimationStyle.neumorphic.animation.delay(1 + AnimationStyle.neumorphic.duration)) {
      isShowingResult = true
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(level: .hard)
  }
}

