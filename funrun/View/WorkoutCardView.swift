//
//  WorkoutCardView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct WorkoutCardView: View {
    @ObservedObject var viewModel: WorkoutCardViewModel
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: viewModel.sfSymbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: viewModel.tracker.isTracking ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: viewModel.tracker.isTracking ? .repeating : .nonRepeating, value: viewModel.tracker.isTracking)
                        .font(.title)
                        .padding()
                } else {
                    // Fallback on earlier versions
                }
                
                Button(action: {
                    viewModel.toggleTracking()
                    if viewModel.tracker.isTracking {
                        isShowing = true
                    }
                }) {
                    Text(viewModel.tracker.isTracking ? "Stop \(viewModel.title)" : "Start \(viewModel.title)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(viewModel.tracker.isTracking ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Text(viewModel.tracker.durationCounter.elapsedTime)
                .font(.title3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .cardBackground()
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        let hiitTracker = HIITTracker()
        return WorkoutCardView(viewModel: WorkoutCardViewModel(tracker: hiitTracker, title: "HIIT", sfSymbolImage: "figure.highintensity.intervaltraining"), isShowing: .constant(false))
    }
}
