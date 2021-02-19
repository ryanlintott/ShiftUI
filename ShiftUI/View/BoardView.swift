//
//  BoardView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct BoardView: View {
    
    @StateObject var board: ShiftBoard = ShiftBoard(columns: 3, rows: 4)
    
    let size: CGFloat = 100
    
    var gridColumns: [GridItem] {
        Array<GridItem>.init(repeating: GridItem(.fixed(size)), count: 3)
    }
    
    var body: some View {
        LazyVGrid(columns: gridColumns, alignment: .center, spacing: nil) {
            ForEach(board.positions.sorted()) { position in
                switch position {
                case let .occupied(square):
                    Text("\(square.log)")
                        .frame(width: size, height: size)
                        .background(color(for: square.position.direction(to: board.emptyPosition)))
                        .onTapGesture {
                            withAnimation {
                                board.shift(square)
                            }
                        }
                case .empty:
                    Text("Empty")
                        .font(.caption2)
                        .frame(width: size, height: size)
                }
            }
        }
        
//        VStack {
//            ForEach(1..<board.totalRows + 1) { row in
//                HStack {
//                    ForEach(board.row(row)) { position in
//                        switch position {
//                        case let .occupied(square):
//                            Text("\(square.solvedPosition.column) x \(square.solvedPosition.row)")
//                                .frame(width: 40, height: 40)
//                                .background(color(for: square.shiftableDirection))
//                                .onTapGesture {
//                                    board.shift(square)
//                                }
//                        case let .empty(emptyPosition):
//                            Text("\(emptyPosition.column)|\(emptyPosition.row)")
//                                .frame(width: 40, height: 40)
//                        }
//                    }
//                }
//            }
//        }
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
