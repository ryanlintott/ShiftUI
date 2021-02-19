//
//  ShiftModel.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

//class ShiftModel: ObservableObject {
//
//    let columns: Int
//    let rows: Int
//    @Published var squares: Set<ShiftSquare> = []
//
//    init(columns: Int, rows: Int) {
//        self.columns = columns
//        self.rows = rows
//
//        for row in 1...rows {
//            for column in 1...columns {
//                if row == rows && column == columns {
//                    // skip the last element to create a gap
//                    continue
//                } else {
//                    squares.insert(ShiftSquare(solvedPosition: Position(row: row, column: columns)))
//                }
//            }
//        }
//    }
//
//    func shift(direction: Direction) {
//
//    }
//}

class ShiftBoard: ObservableObject {
    let columns: Int
    let rows: Int
    @Published var emptySquare: Position
    @Published var squares: Set<ShiftSquare> = []
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        self.emptySquare = Position(row: rows, column: columns)
        createSquares()
    }
    
    func createSquares() {
        squares = []
        for row in 1...rows {
            for column in 1...columns {
                if emptySquare == Position(row: row, column: column) {
                    continue
                } else {
                    squares.insert(ShiftSquare(board: self, solvedPosition: Position(row: row, column: columns)))
                }
            }
        }
    }
    
    func squaresAbove(_ square: ShiftSquare) -> Set<ShiftSquare> {
        squares.filter({  $0.column == square.column && $0.row < square.row && $0.row > emptySquare.row})
    }
    
    func squaresBelow(_ square: ShiftSquare) -> Set<ShiftSquare> {
        squares.filter({  $0.column == square.column && $0.row > square.row && $0.row < emptySquare.row })
    }
    
    func squaresLeftOf(_ square: ShiftSquare) -> Set<ShiftSquare> {
        squares.filter({  $0.row == square.row && $0.column < square.column && $0.column > emptySquare.column })
    }
    
    func squaresRightOf(_ square: ShiftSquare) -> Set<ShiftSquare> {
        squares.filter({  $0.row == square.row && $0.column > square.column && $0.column < emptySquare.column })
    }
    
    func shift(_ square: ShiftSquare) {
        switch square.shiftableDirection {
        case .none:
            return
        case .up:
            squaresAbove(square).forEach({ $0.row -= 1 })
        case .down:
            squaresBelow(square).forEach({ $0.row += 1 })
        case .left:
            squaresLeftOf(square).forEach({ $0.column -= 1 })
        case .right:
            squaresRightOf(square).forEach({ $0.column += 1 })
        }
        
        emptySquare = square.position
    }
}
