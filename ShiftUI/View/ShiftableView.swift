//
//  ShiftableView.swift
//  ShiftUI
//
//  Created by Ryan Lintott on 2021-02-20.
//

import SwiftUI
import CoreHaptics

struct ShiftableView<Content: View>: View {
  @EnvironmentObject var board: ShiftBoard
  
  let square: ShiftSquare
  let tileSize: CGFloat
  let content: (Bool) -> Content

  @State private var predictedDragOffset: CGSize = .zero
  @GestureState private var isDragging: Bool = false
  @State private var engine: CHHapticEngine?

  var body: some View {
    content(isDragging)
      .offset(tileOffset)
      .gesture(shiftGesture)
      .onChange(of: isDragging) { isDragging in
        if isDragging {
          prepareHaptics()
        } else {
          withAnimation(Animation.spring(response: 0.1, dampingFraction: 0.95, blendDuration: 0.5)) {
            board.dragEnded(finalAmount: dragAmount(predictedDragOffset))
          }
          playHaptic()
        }
        predictedDragOffset = .zero
      }
  }
  
  func prepareHaptics() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    do {
      self.engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("There was an error creating the engine: \(error.localizedDescription)")
    }
  }
  
  func playHaptic() {
    // make sure that the device supports haptics
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
    
    // create one intense, sharp tap
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)
    
    // convert those events into a pattern and play it immediately
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern: \(error.localizedDescription).")
    }
  }
  
  var tileOffset: CGSize {
    if square == board.activeSquare {
      return tileOffset(amount: board.dragAmount)
    } else if board.pushedSquares.contains(square) {
      return tileOffset(amount: board.pushedAmount)
    } else {
      return .zero
    }
  }
  
  func tileOffset(amount: Double) -> CGSize {
    let offset = CGFloat(amount) * tileSize
    switch board.dragDirection {
    case .up:
      return CGSize(width: 0, height: -offset)
    case .down:
      return CGSize(width: 0, height: offset)
    case .left:
      return CGSize(width: -offset, height: 0)
    case .right:
      return CGSize(width: offset, height: 0)
    case .none:
      return .zero
    }
  }
  
  var shiftGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .updating($isDragging) { value, gestureState, transaction in
        gestureState = true
      }
      .onChanged { value in
        predictedDragOffset = value.predictedEndTranslation
        board.drag(square, amount: dragAmount(value.translation))
      }
  }
  
  func dragAmount(_ translation: CGSize) -> Double {
    Double(dragOffset(translation) / tileSize)
  }
  
  func dragOffset(_ translation: CGSize) -> CGFloat {
    switch board.shiftableDirection(of: square) {
    case .up:
      return -translation.height
    case .down:
      return translation.height
    case .left:
      return -translation.width
    case .right:
      return translation.width
    case .none:
      return .zero
    }
  }
  
}
