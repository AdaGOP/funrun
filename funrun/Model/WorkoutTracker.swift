//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

//protocol WorkoutTracker {
//    var title: String { get set }
//    var sfSymbolImage: String { get set }
//    func startTracking()
//    func stopTracking()
//}
//
//protocol DistanceTrackable: WorkoutTracker {
//    var distanceInKm: Double { get set }
//    func addDistance(by value: Double)
//}
//
//protocol HIITTrackable: WorkoutTracker {
//    var movementSet: [String: Int] { get set }
//    func addMovementSet(by value: Int)
//}

class RunningTracker: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var isAnimating = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
    var title: String
    
    var sfSymbolImage: String
    
    var distanceInKm: Double = 0.0
    
    init(title: String, sfSymbolImage: String, distanceInKm: Double) {
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        self.distanceInKm = distanceInKm
    }
    
    func startTracking() {
        isTracking = true
        startTimer()
    }
    
    func stopTracking() {
        isTracking = false
        stopTimer()
    }
    
    func addDistance(by value: Double){
        distanceInKm += value
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
    
    func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
    }
}

class HIITTracker: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var isAnimating = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
    var title: String
    
    var sfSymbolImage: String
    
    var movementSet: [String: Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
    
    init(title: String, sfSymbolImage: String, movementSet: [String : Int]) {
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        self.movementSet = movementSet
    }
    
    func startTracking() {
        isTracking = true
        startTimer()
    }
    
    func stopTracking() {
        isTracking = false
        stopTimer()
    }
    
    func addMovementSet(by value: Int) {
        movementSet["Jumping-Jack"]! += value
        movementSet["Sit-Up"]! += value
        movementSet["Push-Up"]! += value
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
    
    func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
    }
}
