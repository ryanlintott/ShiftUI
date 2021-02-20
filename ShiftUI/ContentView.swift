//
//  ContentView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Color.offWhite.edgesIgnoringSafeArea(.all)

        BoardView()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
