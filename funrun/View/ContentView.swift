//
//  ContentView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var runningViewModel = RunningViewModel()
    @StateObject var walkingViewModel = WalkingViewModel()
    @StateObject var hiitViewModel = HIITViewModel()
    @State private var isShowingDetails = false
    
    var body: some View {
        NavigationView {
            VStack {
                WorkoutCardView(viewModel: WorkoutDetailViewModel(workoutTracker: runningViewModel),
                                isShowing: $isShowingDetails)
                WorkoutCardView(viewModel: WorkoutDetailViewModel(workoutTracker: walkingViewModel),
                                isShowing: $isShowingDetails)
                WorkoutCardView(viewModel: WorkoutDetailViewModel(workoutTracker: hiitViewModel),
                                isShowing: $isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $isShowingDetails, onDismiss: didDismiss, content: {
            List {
                if runningViewModel.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(workoutTracker: runningViewModel))
                }
                if walkingViewModel.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(workoutTracker: walkingViewModel))
                }
                if hiitViewModel.isTracking {
                    WorkoutDetailView(viewModel: WorkoutDetailViewModel(workoutTracker: hiitViewModel))
                }
            }
        })
    }
    
    func didDismiss(){
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}
#Preview {
    ContentView()
}
