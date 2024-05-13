//
//  WorkoutDetailViewModel.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

protocol WorkoutTrackerProtocol {
    var isTracking: Bool { get set }
    func startTracking()
    func stopTracking()
    var sfSymbolImage: String { get }
}

// Abstraction of the view model that can be sent to FitnessDetailsView
class WorkoutDetailViewModel: ObservableObject {
    @Published var workoutTracker: any WorkoutTracker
    private var timer: Timer?
    
    init(workoutTracker: any WorkoutTracker) {
        self.workoutTracker = workoutTracker
    }
    
    var distanceInKm: Double {
        if let originViewModel = workoutTracker as? DistanceTrackable {
            return originViewModel.distanceInKm
        } else {
            return 0.0
        }
    }
    
    var movementSet: [String: Int] {
        if let originViewModel = workoutTracker as? HIITMovementTrackable {
            return originViewModel.movementSet
        } else {
            return ["no-movement": 0]
        }
    }
    
    func toggleTracking() {
        if workoutTracker.isTracking {
            workoutTracker.stopTracking()
        } else {
            workoutTracker.startTracking()
        }
    }
}
