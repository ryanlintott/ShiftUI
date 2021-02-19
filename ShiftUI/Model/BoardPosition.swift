//
//  BoardPosition.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import Foundation

enum BoardPosition: Comparable, Identifiable, Hashable {
    case occupied(square: ShiftSquare)
    case empty(position: Position)
    
    var position: Position {
        switch self {
        case let .occupied(square):
            return square.position
        case let .empty(position):
            return position
        }
    }
    
    var id: BoardPosition {
        self
    }
    
    static func < (lhs: BoardPosition, rhs: BoardPosition) -> Bool {
        lhs.position < rhs.position
    }
}
