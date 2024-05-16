//
//  WorkoutCardViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var tracker: WorkoutTracker
    @Published var isTracking: Bool = false
    @Published var isAnimating: Bool = false
    @Published var durationCounter: DurationCounter = DurationCounter()
    private var timer: Timer?
    
//    private var cancellables = Set<AnyCancellable>()
    
    init(tracker: WorkoutTracker) {
        self.tracker = tracker
        
//        tracker.objectWillChange
//            .sink { [weak self] _ in
//                self?.objectWillChange.send()
//            }
//            .store(in: &cancellables)
    }
    
    func startTracking() {
        isTracking = true
        startTimer()
        if let distanceTrackable = tracker as? DistanceTrackable {
            distanceTrackable.addDistance(by: 1.5)
        }
        if let hiitTrackable = tracker as? HIITTrackable {
            hiitTrackable.addMovementSet(by: 1)
        }
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

extension WorkoutViewModel {
    @ViewBuilder
    func customDistanceTrackableView() -> some View {
        if let distanceTrackable = tracker as? DistanceTrackable {
            Text("\(DistanceMetric(name: "Distance", value: distanceTrackable.distanceInKm, unit: "km"))")
        }else{
            EmptyView()
        }
    }
    
    @ViewBuilder
    func customHiitTrackableView() -> some View {
        if let hiitTrackable = tracker as? HIITTrackable {
            ForEach(hiitTrackable.movementSet.keys.sorted(), id: \.self) { movementKey in
                Text("\(MovementMetric(movement: movementKey, numOfSet: hiitTrackable.movementSet[movementKey] ?? 0, unit: "set"))")
            }
        }else{
            EmptyView()
        }
    }
}
