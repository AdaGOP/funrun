//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

// Protocol for the common tracking functionality
protocol WorkoutTracker {
    var isTracking: Bool { get }
    var durationCounter: DurationCounter { get }
    var title: String { get }
    var sfSymbolImage: String { get }
    func startTracking()
    func stopTracking()
}

protocol DistanceTrackable: WorkoutTracker {
    var distanceInKm: Double { get }
}

protocol HIITMovementTrackable: WorkoutTracker {
    var movementSet: [String: Int] { get }
}

// Parent Class View model for 3 other view models
class WorkoutTrackerViewModel: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?

    func startTracking() {
        isTracking = true
        startTimer()
    }

    func stopTracking() {
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
}

// View model for running
class RunningViewModel: WorkoutTrackerViewModel, DistanceTrackable {
    var title: String = "Running"
    var sfSymbolImage: String = "figure.run"
    var distanceInKm: Double = 0.0

    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }

    override func stopTracking() {
        super.stopTracking()
        // Stop tracking logic for running
    }
}

// View model for walking
class WalkingViewModel: WorkoutTrackerViewModel, DistanceTrackable {
    var title: String = "Walking"
    var sfSymbolImage: String = "figure.walk"
    var distanceInKm: Double = 0.0

    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }

    override func stopTracking() {
        super.stopTracking()
        // Stop tracking logic for walking
    }
}

class HIITViewModel: WorkoutTrackerViewModel, HIITMovementTrackable {
    var title: String = "HIIT"
    var sfSymbolImage: String = "figure.highintensity.intervaltraining"
    var movementSet: [String : Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]

    override func startTracking() {
        super.startTracking()
        movementSet["Jumping-Jack"]! += 1
        movementSet["Sit-Up"]! += 1
        movementSet["Push-Up"]! += 1
    }

    override func stopTracking() {
        super.stopTracking()
        // Stop tracking logic for HIIT
    }
}
