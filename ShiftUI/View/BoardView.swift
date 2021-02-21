//
//  BoardView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct BoardView: View {
  @EnvironmentObject var board: ShiftBoard
  
  let boardWidth: CGFloat = 300
  var tileSize: CGFloat {
    boardWidth / CGFloat(board.totalColumns)
  }
  var boardHeight: CGFloat {
    tileSize * CGFloat(board.totalRows)
  }
  
  var gridColumns: [GridItem] {
    Array<GridItem>.init(
      repeating: GridItem(.fixed(tileSize), spacing: 0),
      count: board.totalColumns
    )
  }
  
  var body: some View {
    LazyVGrid(columns: gridColumns, alignment: .center, spacing: 0) {
      ForEach(board.positions.sorted()) { position in
        VStack {
          switch position {
          case let .occupied(square):
            ShiftableView(square: square, tileSize: tileSize) { isShifting in
              RoundedRectangle(cornerRadius: 5)
                .neumorphicShadow(height: board.shiftingSquares.contains(square) ? -4 : 4)
                .overlay(
                  Text("\(number(of: square))")
                )
                .padding(5)
            }
            
          case .empty:
            Color.clear
          }
        }
        .frame(width: tileSize, height: tileSize)
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
      .environmentObject(ShiftBoard(level: .medium))
  }
}
