//
//  ShiftSquare.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

struct Position: Equatable, Hashable, Comparable {
    let row: Int
    let column: Int
    
    static func < (lhs: Position, rhs: Position) -> Bool {
        lhs.row < rhs.row || (lhs.row == rhs.row && lhs.column < rhs.column)
    }
}

enum Direction {
    case up, down, left, right, none
}

class ShiftSquare: Hashable, Comparable, Identifiable {
    var column: Int
    var row: Int
    var shiftableDirections: Set<Direction> = []
    let solvedPosition: Position
    let board: ShiftBoard
    
    init(board: ShiftBoard, solvedPosition: Position) {
        self.board = board
        self.solvedPosition = solvedPosition
        self.column = solvedPosition.column
        self.row = solvedPosition.row
    }
    
    var position: Position {
        Position(row: row, column: column)
    }
    
    var shiftableDirection: Direction {
        if board.emptySquare.row == row {
            return board.emptySquare.column < column ? .left : .right
        } else if board.emptySquare.column == column {
            return board.emptySquare.row < row ? .up : .down
        } else {
            return .none
        }
    }
    
    func shiftableDirection(on board: ShiftBoard) -> Direction {
        if board.emptySquare.row == row {
            return board.emptySquare.column < column ? .left : .right
        } else if board.emptySquare.column == column {
            return board.emptySquare.row < row ? .up : .down
        } else {
            return .none
        }
    }
    
    func shift(on board: ShiftBoard) {
        board.shift(self)
    }
    
    func shift() {
        board.shift(self)
    }
    
    var id: Position {
        solvedPosition
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ShiftSquare, rhs: ShiftSquare) -> Bool {
        lhs.solvedPosition == rhs.solvedPosition
    }
    
    static func < (lhs: ShiftSquare, rhs: ShiftSquare) -> Bool {
        lhs.position < rhs.position
    }
}
