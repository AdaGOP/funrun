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
                WorkoutCardView(viewModel:  viewModel.walkingTracker, isShowing: $viewModel.isShowingDetails)
                WorkoutCardView(viewModel: viewModel.hiitTracker, isShowing: $viewModel.isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $viewModel.isShowingDetails, onDismiss: viewModel.didDismiss, content: {
            List {
                if viewModel.runningTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(tracker: viewModel.runningTracker.tracker, title: viewModel.runningTracker.title, sfSymbolImage: viewModel.runningTracker.sfSymbolImage))
                }
                if viewModel.walkingTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(tracker: viewModel.walkingTracker.tracker, title: viewModel.walkingTracker.title, sfSymbolImage: viewModel.walkingTracker.sfSymbolImage))
                }
                if viewModel.hiitTracker.tracker.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(tracker: viewModel.hiitTracker.tracker, title: viewModel.hiitTracker.title, sfSymbolImage: viewModel.hiitTracker.sfSymbolImage))
                }
            }
        })
    }
}

#Preview
{
    ContentView()
}
