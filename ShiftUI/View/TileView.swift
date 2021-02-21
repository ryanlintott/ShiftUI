//
//  TileView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

struct TileView: View {
  @EnvironmentObject var board: ShiftBoard
  
  let square: ShiftSquare
  
  @State private var isVisible: Bool = false
  
  var number: Int {
    board.number(of: square)
  }
  
  var neumorphicHeight: CGFloat {
    board.isSolved || board.shiftingSquares.contains(square) ? -4 : 4
  }
  
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .neumorphicShadow(isActive: isVisible, height: neumorphicHeight)
      .overlay(
        Text("\(board.number(of: square))")
          .opacity(isVisible ? 1 : 0)
      )
      .padding(4)
      .onAppear {
        isVisible = true
      }
      .onDisappear {
        isVisible = false
      }
  }
}

struct TileView_Previews: PreviewProvider {
  static var previews: some View {
    TileView(square: ShiftSquare(solvedPosition: Position(row: 1, column: 1)))
      .environmentObject(ShiftBoard(level: .easy))
  }
}
