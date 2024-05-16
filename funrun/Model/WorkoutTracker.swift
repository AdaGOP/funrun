//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

class WorkoutTracker {
    var title: String = ""
    var sfSymbolImage: String = ""
}

protocol DistanceTrackable {
    var distanceInKm: Double { get set }
}

protocol HIITTrackable {
    var movementSet: [String: Int] { get set }
}

class RunningTracker: WorkoutTracker, DistanceTrackable {
    var distanceInKm: Double = 0.0
}

class WalkingTracker: WorkoutTracker, DistanceTrackable {
    var distanceInKm: Double = 0.0
}

class HIITTracker: WorkoutTracker, HIITTrackable {
    var movementSet: [String: Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
}
