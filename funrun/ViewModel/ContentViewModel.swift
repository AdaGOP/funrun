//
//  ContentViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var runningTracker = WorkoutCardViewModel(tracker: RunningTracker())
    @Published var walkingTracker = WorkoutCardViewModel(tracker: WalkingTracker())
    @Published var hiitTracker = WorkoutCardViewModel(tracker: HIITTracker())
    @Published var isShowingDetails = false
    
    func didDismiss() {
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}
