//
//  ContentView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var runningTracker = RunningTracker()
    @StateObject var walkingTracker = WalkingTracker()
    @StateObject var hiitTracker = HIITTracker()
    @State private var isShowingDetails = false
    
    var body: some View {
        NavigationView {
            VStack {
                WorkoutCardView(tracker: runningTracker, isShowing: $isShowingDetails)
                WorkoutCardView(tracker: walkingTracker, isShowing: $isShowingDetails)
                WorkoutCardView(tracker: hiitTracker, isShowing: $isShowingDetails)
            }
            .navigationTitle("Exercises")
            
        }.sheet(isPresented: $isShowingDetails, onDismiss: didDismiss, content: {
            List {
                if runningTracker.isTracking {
                    WorkoutDetailView(tracker: runningTracker)
                }
                if walkingTracker.isTracking {
                    WorkoutDetailView(tracker: walkingTracker)
                }
                if hiitTracker.isTracking {
                    WorkoutDetailView(tracker: hiitTracker)
                }
            }
        })
    }
    
    func didDismiss(){
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#Preview {
    ContentView()
}
