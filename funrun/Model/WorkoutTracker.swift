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
