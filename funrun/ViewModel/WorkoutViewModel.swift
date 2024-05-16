//
//  WorkoutCardViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    
    var tracker: WorkoutTracker
    var title: String
    var sfSymbolImage: String
    
    private var timer: Timer?
    
    init(tracker: WorkoutTracker, title: String, sfSymbolImage: String) {
        self.tracker = tracker
        self.title = title
        self.sfSymbolImage = sfSymbolImage
    }
    
    func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
    }
    
    private func startTracking() {
        isTracking = true
        startTimer()
        tracker.startTracking()
    }
    
    private func stopTracking() {
        isTracking = false
        stopTimer()
        tracker.stopTracking()
    }
    
    private func startTimer() {
        durationCounter.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.durationCounter.update()
        }
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        durationCounter.startTime = nil
    }
}
