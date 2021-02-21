//
//  BoardView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct BoardView: View {
  @EnvironmentObject var board: ShiftBoard
  @State private var visibleTileNumberThreshold: Int = 0
  
  let availableSize: CGSize
  
  var delayPerTile: Double {
    AnimationStyle.neumorphic.duration / Double(board.squares.count)
  }
  var speedPerTile: Double {
    delayPerTile * 4
  }
  
  var tileSize: CGFloat {
    min(availableSize.width / CGFloat(board.totalColumns), availableSize.height / CGFloat(board.totalRows))
  }
  
  var gridColumns: [GridItem] {
    Array<GridItem>.init(
      repeating: GridItem(.fixed(tileSize), spacing: 0),
      count: board.totalColumns
    )
  }
  
  var body: some View {
    VStack {
      Spacer(minLength: 0)
      
      LazyVGrid(columns: gridColumns, alignment: .center, spacing: 0) {
        ForEach(board.positions.sorted()) { position in
          VStack {
            switch position {
            case let .occupied(square):
              if board.number(of: square) <= visibleTileNumberThreshold {
                ShiftableView(square: square, tileSize: tileSize) { isShifting in
                  TileView(square: square)
                }
              }
            case .empty:
              Color.clear
            }
          }
          .frame(width: tileSize, height: tileSize)
        }
      }
    }
    .onAppear {
      for i in 0...board.squares.count {
        withAnimation(Animation.easeInOut(duration: speedPerTile).delay(Double(i) * delayPerTile + AnimationStyle.neumorphic.duration)) {
          visibleTileNumberThreshold = i
        }
      }
    }
    .onDisappear {
      for i in stride(from: board.squares.count, to: 0, by: -1) {
        withAnimation(Animation.easeInOut(duration: speedPerTile).delay(Double(i) * delayPerTile)) {
          visibleTileNumberThreshold = i
        }
      }
    }
  }
  
  
}

struct BoardView_Previews: PreviewProvider { 
  static var previews: some View {
    GeometryReader { proxy in
      BoardView(availableSize: proxy.size)
        .environmentObject(ShiftBoard(level: .hard))
    }
  }
}
