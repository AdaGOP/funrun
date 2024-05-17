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
    private var timer: Timer?
    
    var tracker: WorkoutTracker
    
    init(tracker: WorkoutTracker) {
        self.tracker = tracker
    }
    
    var title: String {
        tracker.title
    }
    
    var sfSymbolImage: String {
        tracker.sfSymbolImage
    }
    
    var distanceInKm: Double {
        if let distanceTrackable = tracker as? DistanceTrackable {
            return distanceTrackable.distanceInKm
        }
        return 0.0
    }
    
    var movementSet: [String: Int] {
        if let hiitTrackable = tracker as? HIITTrackable {
            return hiitTrackable.movementSet
        }
        return [:]
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
        updateTrackerData()
    }
    
    private func stopTracking() {
        isTracking = false
        stopTimer()
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
    
    private func updateTrackerData() {
        switch tracker {
        case let runningTracker as RunningTracker:
            runningTracker.distanceInKm += 1.5
        case let walkingTracker as WalkingTracker:
            walkingTracker.distanceInKm += 1.5
        case let hiitTracker as HIITTracker:
            hiitTracker.movementSet["Jumping-Jack"]! += 1
            hiitTracker.movementSet["Sit-Up"]! += 1
            hiitTracker.movementSet["Push-Up"]! += 1
        default:
            break
        }
    }
}
