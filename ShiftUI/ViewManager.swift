//
//  ViewManager.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import SwiftUI

enum ViewState {
  case none, home, game
}

class ViewManager: ObservableObject {
  @Published private(set) var activeView: ViewState = .home
  
  func changeViewNeumorphic(to viewState: ViewState) {
    withAnimation(AnimationStyle.neumorphic.animation) {
      activeView = .none
    }
    withAnimation(AnimationStyle.neumorphic.animation.delay(AnimationStyle.neumorphic.duration)) {
      self.activeView = viewState
    }
  }
}
