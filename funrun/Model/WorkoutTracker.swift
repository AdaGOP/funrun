//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation
import Combine

class WorkoutTracker: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    var title: String = ""
    var sfSymbolImage: String = ""
    private var timer: Timer?
    
    func startTracking() {
        isTracking = true
        startTimer()
    }
    
    func stopTracking() {
        isTracking = false
        stopTimer()
    }
    
    func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
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

protocol DistanceTrackable {
    var distanceInKm: Double { get set }
}

protocol HIITTrackable {
    var movementSet: [String: Int] { get set }
}

class RunningTracker: WorkoutTracker, DistanceTrackable {
    var distanceInKm: Double = 0.0
    
    override init() {
        super.init()
        title = "Running"
        sfSymbolImage = "figure.run"
    }
    
    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }
}

class WalkingTracker: WorkoutTracker, DistanceTrackable {
    var distanceInKm: Double = 0.0
    
    override init() {
        super.init()
        title = "Walking"
        sfSymbolImage = "figure.walk"
    }
    
    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }
}

class HIITTracker: WorkoutTracker, HIITTrackable {
    var movementSet: [String: Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
    
    override init() {
        super.init()
        title = "HIIT"
        sfSymbolImage = "figure.highintensity.intervaltraining"
    }
    
    override func startTracking() {
        super.startTracking()
        movementSet["Jumping-Jack"]! += 1
        movementSet["Sit-Up"]! += 1
        movementSet["Push-Up"]! += 1
    }
}
