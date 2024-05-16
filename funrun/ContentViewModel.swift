//
//  ContentViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var runningTracker = RunningTracker()
    @Published var walkingTracker = WalkingTracker()
    @Published var hiitTracker = HIITTracker()
    @Published var isShowingDetails = false
    
    func didDismiss() {
        isShowingDetails = false
        print("caller page processing dismiss")
    }
}
