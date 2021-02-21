//
//  ShiftModel.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

class ShiftBoard: ObservableObject {
  private(set) var totalRows: Int = 0
  private(set) var totalColumns: Int = 0
  
  @Published private(set) var squares: Set<ShiftSquare> = []
  @Published private(set) var emptyPosition: Position = Position(row: 0, column: 0)
  @Published private(set) var activeSquare: ShiftSquare? = nil
  @Published private(set) var dragAmount: Double = 0 {
    didSet {
      pushedAmount = max(dragAmount, pushedAmount)
    }
  }
  @Published private(set) var pushedAmount: Double = 0
  @Published private(set) var moves: Int = 0
  var isSolved: Bool {
    squares.isSolved
  }
  func number(of square: ShiftSquare) -> Int {
    (square.solvedPosition.row - 1) * totalColumns + square.solvedPosition.column
  }
  
  var dragDirection: Direction {
    guard let activeSquare = activeSquare else {
      return .none
    }
    return shiftableDirection(of: activeSquare)
  }
  var pushedSquares: Set<ShiftSquare> {
    guard let activeSquare = activeSquare else {
      return []
    }
    return pushableSquares(whenShifting: activeSquare)
  }
  var shiftingSquares: Set<ShiftSquare> {
    guard let activeSquare = activeSquare else {
      return []
    }
    return pushedSquares.union([activeSquare])
  }
  
  init(level: Level = .easy) {
    initBoard(level: level)
  }
  
  func initBoard(level: Level) {
    initBoard(rows: level.rows, columns: level.columns)
  }
  
  func initBoard(rows: Int, columns: Int) {
    totalRows = rows
    totalColumns = columns
    emptyPosition = Position(row: rows, column: columns)
    squares = []
    for row in 1...totalRows {
      for column in 1...totalColumns {
        let squarePosition = Position(row: row, column: column)
        if emptyPosition != squarePosition {
          squares.insert(ShiftSquare(solvedPosition: squarePosition))
        }
      }
    }
  }
  
  var positions: [BoardPosition] {
    (squares.map({ BoardPosition.occupied(square: $0) }) + [.empty(position: emptyPosition)]).sorted()
  }
  
  func shiftableDirection(of square: ShiftSquare) -> Direction {
    square.position.direction(to: emptyPosition)
  }
  
  func pushableSquares(whenShifting square: ShiftSquare) -> Set<ShiftSquare> {
    Set(squares.filter({ $0.position.isBetween(a: square.position, b: emptyPosition) }))
  }
  
  public func drag(_ square: ShiftSquare, amount: Double) {
    activeSquare = square
    dragAmount = min(max(0, amount), 1)
  }
  
  public func dragEnded(finalAmount: Double? = nil) {
    if let finalAmount = finalAmount {
      dragAmount = finalAmount
    }
    if let activeSquare = activeSquare {
      if dragAmount >= 0.5 {
        moves += 1
        shift(activeSquare)
      } else if pushedAmount >= 0.5 {
        moves += 1
        pushedSquares.forEach({
          squares.update(with: $0.shifting(dragDirection))
        })
        emptyPosition = activeSquare.position.shifting(direction: dragDirection)
      }
    }
    activeSquare = nil
    dragAmount = 0
    pushedAmount = 0
  }
  
  func shift(_ square: ShiftSquare) {
    let direction = shiftableDirection(of: square)
    let pushableSquares = self.pushableSquares(whenShifting: square)
    squares.update(with: square.shifting(direction))
    pushableSquares.forEach({
      squares.update(with: $0.shifting(direction))
    })
    if direction != .none {
      emptyPosition = square.position
    }
  }
  
  func randomShift() {
    if let square = squares.filter({ $0.position.sharesColumn(with: emptyPosition) || $0.position.sharesRow(with: emptyPosition) }).randomElement() {
      shift(square)
    }
  }
  
  public func shuffleBoard() {
    for i in 0...100 {
      if i % 2 == 0 {
        // shift vertical
        if let square = squares.filter({ $0.position.sharesColumn(with: emptyPosition) }).randomElement() {
          shift(square)
        }
      } else {
        // shift horizontal
        if let square = squares.filter({ $0.position.sharesRow(with: emptyPosition) }).randomElement() {
          shift(square)
        }
      }
    }
  }
}

