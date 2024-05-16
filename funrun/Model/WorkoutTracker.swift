//
//  WorkoutTracker.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

protocol WorkoutTracker {
    var title: String { get set }
    var sfSymbolImage: String { get set }
    func startTracking()
    func stopTracking()
}

protocol DistanceTrackable: WorkoutTracker {
    var distanceInKm: Double { get set }
    func addDistance(by value: Double)
}

protocol HIITTrackable: WorkoutTracker {
    var movementSet: [String: Int] { get set }
    func addMovementSet(by value: Int)
}

class RunningTracker: DistanceTrackable, ObservableObject {
    var title: String
    
    var sfSymbolImage: String
    
    var distanceInKm: Double = 0.0
    
    init(title: String, sfSymbolImage: String, distanceInKm: Double) {
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        self.distanceInKm = distanceInKm
    }
    
    func startTracking() {
        //specific logic for the startTracking event
    }
    
    func stopTracking() {
        //specific logic for the stopTracking event
    }
    
    func addDistance(by value: Double){
        distanceInKm += value
    }
    
}

class WalkingTracker: DistanceTrackable {
    var title: String
    
    var sfSymbolImage: String
    
    var distanceInKm: Double = 0.0
    init(title: String, sfSymbolImage: String, distanceInKm: Double) {
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        self.distanceInKm = distanceInKm
    }
    
    func startTracking() {
        //specific logic for the startTracking event
    }
    
    func stopTracking() {
        //specific logic for the stopTracking event
    }
    
    func addDistance(by value: Double){
        distanceInKm += value
    }
}

class HIITTracker: HIITTrackable {
    var title: String
    
    var sfSymbolImage: String
    
    var movementSet: [String: Int] = ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]
    
    init(title: String, sfSymbolImage: String, movementSet: [String : Int]) {
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        self.movementSet = movementSet
    }
    
    func startTracking() {
        //specific logic for the startTracking event
    }
    
    func stopTracking() {
        //specific logic for the stopTracking event
    }
    
    func addMovementSet(by value: Int) {
        movementSet["Jumping-Jack"]! += value
        movementSet["Sit-Up"]! += value
        movementSet["Push-Up"]! += value
    }
}
