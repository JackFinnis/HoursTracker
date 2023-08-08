//
//  ViewModel.swift
//  HoursTracker
//
//  Created by Jack Finnis on 08/08/2023.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Storage("state") var state = TrackerState.inactive { didSet {
        objectWillChange.send()
    }}
    @Storage("accumulatedInterval") var accumulatedInterval = 0.0 { didSet {
        objectWillChange.send()
    }}
    @Storage("dateResumed") var dateResumed = Date.now { didSet {
        objectWillChange.send()
    }}
    
    func pause() {
        state = .paused
        accumulatedInterval += dateResumed.intervalToNow
        Haptics.tap()
    }
    
    func resume() {
        state = .active
        dateResumed = .now
        Haptics.tap()
    }
    
    func reset() {
        state = .inactive
        accumulatedInterval = 0
        Haptics.tap()
    }
}
