//
//  Metrics.swift
//  funrun
//
//  Created by David Gunawan on 15/05/24.
//

import Foundation

struct DistanceMetric {
    var name: String
    var value: Double
    var unit: String
}

struct MovementMetric {
    var movement: String
    var numOfSet: Int
    var unit: String
}

extension DistanceMetric: CustomStringConvertible {
    var description: String {
        let formattedValue = String(format: "%.2f", value)
        return "\(name): \(formattedValue) \(unit)"
    }
}

extension MovementMetric: CustomStringConvertible {
    var description: String {
        return "\(movement): \(numOfSet) \(unit)"
    }
}
