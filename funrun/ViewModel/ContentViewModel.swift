//
//  ContentViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var runningTracker: WorkoutViewModel
    @Published var walkingTracker: WorkoutViewModel
    @Published var hiitTracker: WorkoutViewModel
    
    @Published var isShowingDetails = false
    
    init() {
        let runningTracker = RunningTracker()
        runningTracker.title = "Running"
        runningTracker.sfSymbolImage = "figure.run"
        self.runningTracker = WorkoutViewModel(tracker: runningTracker)
        
        let walkingTracker = WalkingTracker()
        walkingTracker.title = "Walking"
        walkingTracker.sfSymbolImage = "figure.walk"
        self.walkingTracker = WorkoutViewModel(tracker: walkingTracker)
        
        let hiitTracker = HIITTracker()
        hiitTracker.title = "HIIT"
        hiitTracker.sfSymbolImage = "figure.highintensity.intervaltraining"
        self.hiitTracker = WorkoutViewModel(tracker: hiitTracker)
    }
    
    func didDismiss() {
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}
