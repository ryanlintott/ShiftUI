//
//  BoardView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct BoardView: View {
    
    @StateObject var board: ShiftBoard = ShiftBoard(columns: 4, rows: 4)
    
    let columns = 4
    let rows = 4
    let boardWidth: CGFloat = 300
    var tileSize: CGFloat {
        boardWidth / CGFloat(columns)
    }
    var boardHeight: CGFloat {
        tileSize * CGFloat(rows)
    }
    
    var gridColumns: [GridItem] {
        Array<GridItem>.init(
          repeating: GridItem(.fixed(tileSize), spacing: 10),
          count: columns
        )
    }
    
    var body: some View {
        LazyVGrid(columns: gridColumns, alignment: .center, spacing: 10) {
            ForEach(board.positions.sorted()) { position in
                VStack {
                    switch position {
                    case let .occupied(square):
                      TileButton(data: number(of: square)) {
                        withAnimation {
                            board.shift(square)
                        }
                      }
                    case .empty:
                        Color.clear
                    }
                }
                .padding(1)
                .frame(width: tileSize, height: tileSize)
            }
        }
    }
    
    func number(of square: ShiftSquare) -> Int {
        (square.solvedPosition.row - 1) * board.totalColumns + square.solvedPosition.column
    }
        
    func debugView(boardPosition: BoardPosition) -> some View {
        VStack {
            switch boardPosition {
            case let .occupied(square):
                Text("\(square.log)")
                    .background(color(for: square.position.direction(to: board.emptyPosition)))
                    .onTapGesture {
                        withAnimation {
                            board.shift(square)
                        }
                    }
            case .empty:
                Text("Empty")
                    .font(.caption2)
            }
        }
        .padding()
        .frame(width: tileSize, height: tileSize)
    }
    
    func color(for direction: Direction) -> Color {
        switch direction {
        case .up:
            return .blue
        case .down:
            return .green
        case .left:
            return .red
        case .right:
            return .yellow
        case .none:
            return .gray
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
