//
//  ShiftSquare.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

struct Position: Equatable, Hashable {
    let row: Int
    let column: Int
}

enum Direction {
    case up, down, left, right, none
}

class ShiftSquare: Hashable {
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
    
}
