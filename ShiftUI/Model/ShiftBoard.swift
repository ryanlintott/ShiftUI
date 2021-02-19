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
    @Published var emptySquare: Position
    @Published var squares: Set<ShiftSquare> = []
    
    init(columns: Int, rows: Int) {
        self.totalColumns = columns
        self.totalRows = rows
        self.emptySquare = Position(row: rows, column: columns)
        createSquares()
    }
    
    func row(_ rowNumber: Int) -> [BoardPosition] {
        var positions: [BoardPosition] = squares.filter({ $0.row == rowNumber }).map({ .occupied(square: $0) } )
        if emptySquare.row == rowNumber {
            positions.append(.empty(position: emptySquare))
        }
        return positions.sorted()
    }
    
    func createSquares() {
        squares = []
        for row in 1...totalRows {
            for column in 1...totalColumns {
                if emptySquare != Position(row: row, column: column) {
                    squares.insert(ShiftSquare(board: self, solvedPosition: Position(row: row, column: column)))
                }
            }
        }
    }
    
    func shiftableDirection(of square: ShiftSquare) -> Direction {
        if square.row == emptySquare.row {
            return square.column < emptySquare.column ? .right : .left
        } else if square.column == emptySquare.column {
            return square.row < emptySquare.row ? .down : .up
        } else {
            return .none
        }
    }
    
    func shiftableSquares(whenShifting square: ShiftSquare) -> Set<ShiftSquare> {
        switch shiftableDirection(of: square) {
        case .none:
            return []
        case .up:
            return squares.filter({ $0.column == square.column && $0.row <= square.row && $0.row > emptySquare.row})
        case .down:
            return squares.filter({  $0.column == square.column && $0.row >= square.row && $0.row < emptySquare.row })
        case .left:
            return squares.filter({  $0.row == square.row && $0.column <= square.column && $0.column > emptySquare.column })
        case .right:
            return squares.filter({  $0.row == square.row && $0.column >= square.column && $0.column < emptySquare.column })
        }
    }
    
    func shift(_ square: ShiftSquare) {
        shiftableSquares(whenShifting: square).forEach({
            switch shiftableDirection(of: square) {
            case .up:
                $0.row -= 1
            case .down:
                $0.row += 1
            case .left:
                $0.column -= 1
            case .right:
                $0.column += 1
            case .none:
                break
            }
        })

        emptySquare = square.position
    }
}
