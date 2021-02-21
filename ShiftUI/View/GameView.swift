//
//  ContentView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct GameView: View {
  @StateObject var board = ShiftBoard()
  @State private var showResult = false
  @Environment(\.presentationMode) var presentationMode

  let level: Level

  var body: some View {
    ZStack {
      NavigationLink(
        destination: ResultView(score: 345),
        isActive: $showResult,
        label: { Color.clear }
      )

      Color.offWhite.edgesIgnoringSafeArea(.all)

      VStack {
        Text("ShiftUI")
          .font(.system(size: 70))
          .fontWeight(.black)
          .neumorphicShadow(height: 3)
        
        HStack {
          Text("Moves:")
          Spacer()
          Text("\(board.moves)")
            .animation(nil)
        }
        .font(.title)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 10)
            .neumorphicShadow(height: 2)
        )
        .padding(.horizontal, 30)
        .padding(.all, 30)
        .onTapGesture { showResult.toggle() } // added for demo purpose only
        
        Spacer()
        
        BoardView()
          .environmentObject(board)
        
        Spacer()
      }
    }
    .foregroundColor(.grayText)
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(
      trailing: Button {
        presentationMode.wrappedValue.dismiss()
      } label: {
        Image(systemName: "xmark.circle")
          .padding(.all, 8)
          .foregroundColor(.grayText)
      }
      .buttonStyle(TileButtonStyle(cornerRadius: 4, height: 2, pressedHeight: -2))
    )
    .onAppear {
      board.initBoard(level: level)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      GameView(level: .medium)
    }
  }
}

