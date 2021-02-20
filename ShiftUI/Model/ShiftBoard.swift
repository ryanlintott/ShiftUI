//
//  ShiftModel.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

class ShiftBoard: ObservableObject {
  let totalColumns: Int
  let totalRows: Int
  
  @Published var squares: Set<ShiftSquare> = []
  @Published var emptyPosition: Position
  
  init(columns: Int, rows: Int) {
    self.totalColumns = columns
    self.totalRows = rows
    self.emptyPosition = Position(row: rows, column: columns)
    createBoard()
  }
  
  func createBoard() {
    for row in 1...totalRows {
      for column in 1...totalColumns {
        let squarePosition = Position(row: row, column: column)
        if emptyPosition != squarePosition {
          squares.insert(ShiftSquare(solvedPosition: squarePosition))
          print(squarePosition)
        }
      }
    }
    print(squares.sorted().map({ $0.log}))
  }
  
  var positions: [BoardPosition] {
    (squares.map({ BoardPosition.occupied(square: $0) }) + [.empty(position: emptyPosition)]).sorted()
  }
  
  func shiftableDirection(of square: ShiftSquare) -> Direction {
    square.position.direction(to: emptyPosition)
  }
  
  func shiftableSquares(whenShifting square: ShiftSquare) -> Set<ShiftSquare> {
    Set(squares.filter({ $0.position.isBetween(a: square.position, b: emptyPosition) }))
  }
  
  func shift(_ square: ShiftSquare) {
    let direction = shiftableDirection(of: square)
    let shiftableSquares = self.shiftableSquares(whenShifting: square)
    if shiftableSquares.contains(square) {
      squares = Set(squares.map({
        shiftableSquares.contains($0) ? $0.shifting(direction) : $0
      }))
      emptyPosition = square.position
    }
  }
}

