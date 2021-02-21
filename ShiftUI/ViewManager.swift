//
//  ViewManager.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import Foundation

enum ViewState {
  case home, game
}

class ViewManager: ObservableObject {
  @Published var activeView: ViewState = .home
}
