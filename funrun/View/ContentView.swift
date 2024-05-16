//
//  ContentView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var runningModel  = RunningTracker(title: "Running", sfSymbolImage: "figure.run", distanceInKm: 0.0)
    @StateObject var hiitModel = HIITTracker(title: "HIIT", sfSymbolImage: "figure.highintensity.intervaltraining", movementSet: ["Jumping-Jack": 0, "Sit-Up": 0, "Push-Up": 0])
    
    @State var isShowingDetails = false
    
    var body: some View {
        NavigationView {
            VStack {
                RunningCardView(runningModel: runningModel, isShowingDetails: $isShowingDetails)
                HiitCardView(hiitModel: hiitModel, isShowingDetails: $isShowingDetails)
                
            }.sheet(isPresented: $isShowingDetails, onDismiss: didDismiss, content: {
                List {
                    if runningModel.isTracking {
                        RunningDetailView(runningModel: runningModel, isAnimating: runningModel.isAnimating)
                    }
                    if hiitModel.isTracking {
                        HiitDetailView(hiitModel: hiitModel, isAnimating: hiitModel.isAnimating)
                    }
                }
            }).navigationTitle("Exercises")
        }
    }
    
    func didDismiss(){
        isShowingDetails = false
    }
}

#Preview
{
    ContentView()
}
