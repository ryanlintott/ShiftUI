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
  @State private var showResult = false
  
  let level: Level

  var body: some View {
    ZStack {
      Color.clear
      
      if showResult {
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
            showResult = true // added for demo purpose only
          }
          
          BoardView()
            .environmentObject(board)
        }
        .padding()
      }
    }
    .onAppear {
      board.initBoard(level: level)
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(level: .hard)
  }
}

