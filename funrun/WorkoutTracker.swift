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
    var heartRateInBpm: Double { get set }
    var durationInMinute: Double { get set }
    var durationCounter: DurationCounter { get set }
    var title: String { get }
    var sfSymbolImage: String { get }
    func startTracking()
    func stopTracking()
}

protocol DistanceTrackable: WorkoutTracker {
    var distanceInKm: Double { get set }
}

protocol HIITMovementTrackable: WorkoutTracker {
    var movementSet: [String: Int] { get set }
}

// View model for running
class RunningViewModel: ObservableObject, DistanceTrackable {
    @Published var isTracking: Bool = false
    var heartRateInBpm: Double = 0.0
    var durationInMinute: Double = 0.0
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
    var title: String = "Running"
    var sfSymbolImage: String = "figure.run"
    var distanceInKm: Double = 0.0
    
    func startTracking() {
        print("Starting running tracker...")
        // Start tracking logic for running
        isTracking = true
        distanceInKm += 1.5

        // Start the timer
        durationCounter.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.durationCounter.update()
        }
    }
    
    func stopTracking() {
        print("Stopping running tracker...")
        // Stop tracking logic for running
        isTracking = false
        // Stop the timer
        self.timer?.invalidate()
        self.timer = nil
        durationCounter.startTime = nil
    }
}

// View model for walking
class WalkingViewModel: ObservableObject, DistanceTrackable {
    @Published var isTracking: Bool = false
    var heartRateInBpm: Double = 0.0
    var durationInMinute: Double = 0.0
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
    var title: String = "Walking"
    var sfSymbolImage: String = "figure.walk"
    @Published var distanceInKm: Double = 0.0
    
    func startTracking() {
        print("Starting walking tracker...")
        // Start tracking logic for walking
        isTracking = true
        distanceInKm += 1.5
        
        // Start the timer
        durationCounter.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.durationCounter.update()
        }
    }
    
    func stopTracking() {
        print("Stopping walking tracker...")
        // Stop tracking logic for walking
        isTracking = false
        // Stop the timer
        self.timer?.invalidate()
        self.timer = nil
        durationCounter.startTime = nil
    }
}

// View model for HIIT
class HIITViewModel: ObservableObject, HIITMovementTrackable {
    @Published var isTracking: Bool = false
    var heartRateInBpm: Double = 0.0
    var durationInMinute: Double = 0.0
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
    var title: String = "HIIT"
    var sfSymbolImage: String = "figure.highintensity.intervaltraining"
    @Published var movementSet: [String : Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
    
    func startTracking() {
        print("Starting HIIT tracker...")
        // Start tracking logic for HIIT
        isTracking = true
        movementSet["Jumping-Jack"]! += 1
        movementSet["Sit-Up"]! += 1
        movementSet["Push-Up"]! += 1
        
        // Start the timer
        durationCounter.startTime = Date()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.durationCounter.update()
        }
    }
    
    func stopTracking() {
        print("Stopping HIIT tracker...")
        // Stop tracking logic for HIIT
        isTracking = false
        // Stop the timer
        self.timer?.invalidate()
        self.timer = nil
        durationCounter.startTime = nil
    }
}
