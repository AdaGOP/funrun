//
//  WorkoutDetailView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var tracker: WorkoutTracker
    @State var isAnimating: Bool = false
    
    var body: some View {
        Group {
            Text(tracker.title)
                .font(.title)
            Group {
                HStack {
                    VStack {
                        if #available(iOS 17.0, *) {
                            Image(systemName: tracker.isTracking ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(tracker.durationCounter.elapsedTime)
                            .font(.title3)
                    }
                    VStack(alignment: .leading) {
                        if let distanceTrackable = tracker as? DistanceTrackable {
                            Text("\(DistanceMetric(name: "Distance", value: distanceTrackable.distanceInKm, unit: "km"))")
                        }
                        if let hiitTrackable = tracker as? HIITTrackable {
                            ForEach(hiitTrackable.movementSet.keys.sorted(), id: \.self) { movementKey in
                                Text("\(MovementMetric(movement: movementKey, numOfSet: hiitTrackable.movementSet[movementKey] ?? 0, unit: "set"))")
                            }
                        }
                        
                        Button(action: {
                            tracker.toggleTracking()
                            dismiss()
                        }) {
                            Text(tracker.isTracking ? "Stop Tracking" : "Start Tracking")
                                .font(.headline)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .onAppear {
                isAnimating.toggle()
            }
            .onDisappear {
                isAnimating.toggle()
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let hiitTracker = HIITTracker()
        WorkoutDetailView(tracker: hiitTracker)
    }
}
