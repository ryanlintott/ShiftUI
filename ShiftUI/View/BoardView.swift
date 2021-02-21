//
//  BoardView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct BoardView: View {
  @EnvironmentObject var board: ShiftBoard
  
  func tileSize(in boardSize: CGSize) -> CGFloat {
    min(boardSize.width / CGFloat(board.totalColumns), boardSize.height / CGFloat(board.totalRows))
  }
  
  func gridColumns(in boardSize: CGSize) -> [GridItem] {
    Array<GridItem>.init(
      repeating: GridItem(.fixed(tileSize(in: boardSize)), spacing: 0),
      count: board.totalColumns
    )
  }
  
  var body: some View {
    GeometryReader { proxy in
      VStack {
        Spacer(minLength: 0)
        
        LazyVGrid(columns: gridColumns(in: proxy.size), alignment: .center, spacing: 0) {
          ForEach(board.positions.sorted()) { position in
            VStack {
              switch position {
              case let .occupied(square):
                ShiftableView(square: square, tileSize: tileSize(in: proxy.size)) { isShifting in
                  RoundedRectangle(cornerRadius: 5)
                    .neumorphicShadow(height: board.shiftingSquares.contains(square) ? -4 : 4)
                    .overlay(
                      Text("\(number(of: square))")
                    )
                    .padding(4)
                }
                
              case .empty:
                Color.clear
              }
            }
            .frame(width: tileSize(in: proxy.size), height: tileSize(in: proxy.size))
          }
        }
      }
    }
  }
  
  func number(of square: ShiftSquare) -> Int {
    (square.solvedPosition.row - 1) * board.totalColumns + square.solvedPosition.column
  }
}

struct BoardView_Previews: PreviewProvider { 
  static var previews: some View {
    BoardView()
      .environmentObject(ShiftBoard(level: .hard))
  }
}
