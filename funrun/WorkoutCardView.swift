//
//  WorkoutCardView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct WorkoutCardView: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: viewModel.workoutTracker.sfSymbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height:100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: viewModel.workoutTracker.isTracking ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: viewModel.workoutTracker.isTracking ? .repeating : .nonRepeating, value: viewModel.workoutTracker.isTracking)
                        .font(.title)
                        .padding()
                } else {
                }
                
                
                Button(action: {
                    viewModel.toggleTracking()
                    if viewModel.workoutTracker.isTracking {
                        isShowing = true
                    }
                }) {
                    Text(viewModel.workoutTracker.isTracking ? "Stop \(viewModel.workoutTracker.title)" : "Start \(viewModel.workoutTracker.title)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(viewModel.workoutTracker.isTracking ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
            }
            Text("\(viewModel.workoutTracker.durationCounter.hours):\(viewModel.workoutTracker.durationCounter.minutes):\(viewModel.workoutTracker.durationCounter.seconds)")
                .font(.title3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .cardBackground()
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        let runningViewModel = RunningViewModel()
        return  WorkoutCardView(viewModel: WorkoutDetailViewModel(workoutTracker: runningViewModel) , isShowing: .constant(false))
    }
}
