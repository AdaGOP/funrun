//
//  WorkoutDetailView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

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

// SwiftUI view that uses the WorkoutDetailViewModel
struct WorkoutDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @State var isAnimating: Bool = false
    
    var body: some View {
        Group{
            Text(viewModel.workoutTracker.title)
                .font(.title)
            Group{
                HStack{
                    VStack{
                        if #available(iOS 17.0, *) {
                            Image(systemName: viewModel.workoutTracker.isTracking ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height:100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text("\(viewModel.workoutTracker.durationCounter.hours):\(viewModel.workoutTracker.durationCounter.minutes):\(viewModel.workoutTracker.durationCounter.seconds)")
                            .font(.title3)
                    }
                    VStack(alignment:.leading) {
                        if viewModel.workoutTracker is DistanceTrackable {
                            Text("\(DistanceMetric(name: "Distance", value: viewModel.distanceInKm, unit: "km"))")
                        }
                        if viewModel.workoutTracker is HIITMovementTrackable {
                            ForEach(viewModel.movementSet.keys.sorted(), id: \.self) { movementKey in
                                Text("\(MovementMetric(movement: movementKey, numOfSet: viewModel.movementSet[movementKey] ?? 0, unit: "set"))")
                            }
                        }
                        
                        Button(action: {
                            viewModel.toggleTracking()
                            dismiss()
                        }) {
                            Text(viewModel.workoutTracker.isTracking ? "Stop Tracking" : "Start Tracking")
                                .font(.headline)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }.onAppear{
                isAnimating.toggle()
            }.onDisappear(){
                isAnimating.toggle()
            }
        }
    }
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


struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let runningViewModel = RunningViewModel()
        WorkoutDetailView(viewModel: WorkoutDetailViewModel(workoutTracker: runningViewModel))
    }
}
