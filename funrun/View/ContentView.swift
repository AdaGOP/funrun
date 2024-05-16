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
                WorkoutCardView(viewModel: viewModel.runningTracker, isShowing: $viewModel.isShowingDetails)
                WorkoutCardView(viewModel: viewModel.walkingTracker, isShowing: $viewModel.isShowingDetails)
                WorkoutCardView(viewModel: viewModel.hiitTracker, isShowing: $viewModel.isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $viewModel.isShowingDetails, onDismiss: viewModel.didDismiss, content: {
            List {
                if viewModel.runningTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: viewModel.runningTracker)
                }
                if viewModel.walkingTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: viewModel.walkingTracker)
                }
                if viewModel.hiitTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: viewModel.hiitTracker)
                }
            }
        })
    }
}

#Preview
{
    ContentView()
}
