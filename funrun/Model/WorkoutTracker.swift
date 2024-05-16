//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

class WorkoutTracker {
    var isTracking: Bool = false
    var title: String = ""
    var sfSymbolImage: String = ""

    func startTracking() {
        isTracking = true
    }

    func stopTracking() {
        isTracking = false
    }

    func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
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
    
    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }
}

class WalkingTracker: WorkoutTracker, DistanceTrackable {
    var distanceInKm: Double = 0.0
    
    override func startTracking() {
        super.startTracking()
        distanceInKm += 1.5
    }
}

class HIITTracker: WorkoutTracker, HIITTrackable {
    var movementSet: [String: Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
    
    override func startTracking() {
        super.startTracking()
        movementSet["Jumping-Jack"]! += 1
        movementSet["Sit-Up"]! += 1
        movementSet["Push-Up"]! += 1
    }
}
