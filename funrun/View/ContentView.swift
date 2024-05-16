//
//  ContentView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var runningVM = WorkoutViewModel(tracker: RunningTracker(title: "Running", sfSymbolImage: "figure.run", distanceInKm: 0.0))
    @StateObject var hiitVM = WorkoutViewModel(tracker: HIITTracker(title: "HIIT", sfSymbolImage: "figure.highintensity.intervaltraining", movementSet: ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0]))
    
    @State var isShowingDetails = false
    
    var body: some View {
        NavigationView {
            VStack {
                WorkoutCardView(viewModel: runningVM, isShowingDetails: $isShowingDetails)
                WorkoutCardView(viewModel: hiitVM, isShowingDetails: $isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $isShowingDetails, onDismiss: didDismiss, content: {
            List {
                if runningVM.isTracking {
                    WorkoutDetailView(viewModel: runningVM, isAnimating: false)
                }
                if hiitVM.isTracking {
                    WorkoutDetailView(viewModel: hiitVM, isAnimating: false)
                }
            }
        })
    }
    
    func didDismiss(){
        isShowingDetails = false
    }
}

#Preview
{
    ContentView()
}
