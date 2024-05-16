//
//  WorkoutDetailView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WorkoutViewModel
    @State var isAnimating: Bool = false
    
    var body: some View {
        Group {
            Text(viewModel.title)
                .font(.title)
            Group {
                HStack {
                    VStack {
                        if #available(iOS 17.0, *) {
                            Image(systemName: viewModel.isTracking ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(viewModel.durationCounter.elapsedTime)
                            .font(.title3)
                    }
                    VStack(alignment: .leading) {
                        if let distanceTrackable = viewModel as? DistanceTrackable {
                            Text("\(DistanceMetric(name: "Distance", value: distanceTrackable.distanceInKm, unit: "km"))")
                        }
                        if let hiitTrackable = viewModel as? HIITTrackable {
                            ForEach(hiitTrackable.movementSet.keys.sorted(), id: \.self) { movementKey in
                                Text("\(MovementMetric(movement: movementKey, numOfSet: hiitTrackable.movementSet[movementKey] ?? 0, unit: "set"))")
                            }
                        }
                        
                        Button(action: {
                            viewModel.toggleTracking()
                            dismiss()
                        }) {
                            Text(viewModel.isTracking ? "Stop Tracking" : "Start Tracking")
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
        WorkoutDetailView(viewModel: WorkoutViewModel(tracker: hiitTracker, title: "HIIT", sfSymbolImage: "figure.highintensity.intervaltraining"))
    }
}
