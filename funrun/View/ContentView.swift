//
//  ContentView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                WorkoutCardView(tracker: viewModel.runningTracker, isShowing: $viewModel.isShowingDetails)
                WorkoutCardView(tracker: viewModel.walkingTracker, isShowing: $viewModel.isShowingDetails)
                WorkoutCardView(tracker: viewModel.hiitTracker, isShowing: $viewModel.isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $viewModel.isShowingDetails, onDismiss: viewModel.didDismiss, content: {
            List {
                if viewModel.runningTracker.isTracking {
                    WorkoutDetailView(tracker: viewModel.runningTracker)
                }
                if viewModel.walkingTracker.isTracking {
                    WorkoutDetailView(tracker: viewModel.walkingTracker)
                }
                if viewModel.hiitTracker.isTracking {
                    WorkoutDetailView(tracker: viewModel.hiitTracker)
                }
            }
        })
    }
}
#Preview
{
    ContentView()
}
