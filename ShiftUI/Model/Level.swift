//
//  Level.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-21.
//

import Foundation

enum Level: Int, CaseIterable, Identifiable, RawRepresentable {
  case easy, medium, hard
  
  var id: Int {
    self.rawValue
  }
  var rows: Int {
    switch self {
    case .easy:
      return 4
    case .medium:
      return 5
    case .hard:
      return 6
    }
  }
  
  var columns: Int {
    switch self {
    case .easy:
      return 3
    case .medium:
      return 4
    case .hard:
      return 5
    }
  }
  
  var label: String {
    switch self {
    case .easy:
      return "Easy"
    case .medium:
      return "Medium"
    case .hard:
      return "Hard"
    }
  }
}
