//
//  WorkoutCardView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct WorkoutCardView: View {
    @ObservedObject var tracker: WorkoutTracker
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: tracker.sfSymbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: tracker.isTracking ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: tracker.isTracking ? .repeating : .nonRepeating, value: tracker.isTracking)
                        .font(.title)
                        .padding()
                } else {
                }
                
                Button(action: {
                    tracker.toggleTracking()
                    if tracker.isTracking {
                        isShowing = true
                    }
                }) {
                    Text(tracker.isTracking ? "Stop \(tracker.title)" : "Start \(tracker.title)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(tracker.isTracking ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Text(tracker.durationCounter.elapsedTime)
                .font(.title3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .cardBackground()
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        let runningTracker = RunningTracker()
        return WorkoutCardView(tracker: runningTracker, isShowing: .constant(false))
    }
}
