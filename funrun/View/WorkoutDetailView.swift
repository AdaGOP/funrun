//
//  WorkoutDetailView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI
// SwiftUI view that uses the WorkoutDetailViewModel
struct WorkoutDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @State var isAnimating: Bool = false
    
    var body: some View {
        Group{
            Text(viewModel.workoutTitle)
                .font(.title)
            Group{
                HStack{
                    VStack{
                        if #available(iOS 17.0, *) {
                            Image(systemName: viewModel.trackingState ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height:100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(viewModel.getDuration())
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
                            Text(viewModel.trackingState ? "Stop Tracking" : "Start Tracking")
                                .font(.headline)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }.onAppear {
                isAnimating.toggle()
            }.onDisappear() {
                isAnimating.toggle()
            }
        }
    }
}


struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let runningViewModel = RunningViewModel()
        WorkoutDetailView(viewModel: WorkoutDetailViewModel(workoutTracker: runningViewModel))
    }
}
