//
//  ContentViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var runningTracker = WorkoutViewModel(tracker: RunningTracker(), title: "Running", sfSymbolImage: "figure.run")
    @Published var walkingTracker = WorkoutViewModel(tracker: WalkingTracker(), title: "Walking", sfSymbolImage: "figure.walk")
    @Published var hiitTracker = WorkoutViewModel(tracker: HIITTracker(), title: "HIIT", sfSymbolImage: "figure.highintensity.intervaltraining")
    
    @Published var isShowingDetails = false
    
    func didDismiss() {
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}
