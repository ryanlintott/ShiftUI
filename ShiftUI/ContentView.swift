//
//  ContentView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct ContentView: View {
  @State private var showResult = false
  
  var body: some View {
    ZStack {
      Color.offWhite.edgesIgnoringSafeArea(.all)
      
      VStack {
        Text("ShiftUI")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        HStack {
          Spacer()
          Text("Steps: 5")
            .font(.title)
            .padding()
          Spacer()
        }
        .background(
          RoundedRectangle(cornerRadius: 10).neumorphicShadow()
        )
        .padding(.all, 30)
        .onTapGesture { showResult.toggle() } // added for demo purpose only
        
        Spacer()
        
        BoardView()
      }
    }
    .sheet(isPresented: $showResult){
      ResultView(score: 343)
    }
    .foregroundColor(.grayText)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

