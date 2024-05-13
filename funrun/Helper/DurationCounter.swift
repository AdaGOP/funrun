//
//  DurationCounter.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import Foundation

struct DurationCounter {
    var hours = "00"
    var minutes = "00"
    var seconds = "00"
    
    var startTime: Date?

    var elapsedTime: String {
        guard let startTime = startTime else { return "00:00:00" }
        let duration = Date().timeIntervalSince(startTime)
        let hours = Int(duration / 3600)
        let minutes = Int((duration.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    mutating func update() {
        guard let startTime = startTime else { return }
        let duration = Date().timeIntervalSince(startTime)
        let hour = Int(duration / 3600)
        let minute = Int((duration.truncatingRemainder(dividingBy: 3600)) / 60)
        let second = Int(duration.truncatingRemainder(dividingBy: 60))

        
        self.hours = String(format: "%02d", hour)
        self.minutes = String(format: "%02d", minute)
        self.seconds = String(format: "%02d", second)
    }
}
