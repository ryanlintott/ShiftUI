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
          .onTapGesture {
            isShowingResult = true // added for demo purpose only
          }
          
//          Button {
//            withAnimation {
////              board.randomShift()
//              board.shuffleBoard()
//            }
//          } label: {
//            Text("Random")
//              .padding()
//          }
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
    withAnimation(Animation.easeInOut(duration: 1)) {
      isShowingBoard = true
    }
    withAnimation(Animation.easeInOut(duration: 1).delay(1)) {
      board.shuffleBoard()
    }
  }
  
  func showResults() {
    withAnimation {
      isShowingResult = true
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(level: .hard)
  }
}

