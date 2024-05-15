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
                Image(systemName: viewModel.symbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height:100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: viewModel.trackingState ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: viewModel.trackingState ? .repeating : .nonRepeating, value: viewModel.trackingState)
                        .font(.title)
                        .padding()
                } else {
                }
                
                
                Button(action: {
                    viewModel.toggleTracking()
                    if viewModel.trackingState {
                        isShowing = true
                    }
                }) {
                    Text(viewModel.trackingState ? "Stop \(viewModel.workoutTitle)" : "Start \(viewModel.workoutTitle)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(viewModel.trackingState ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
            }
            Text(viewModel.getDuration())
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
