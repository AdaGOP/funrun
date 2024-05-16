//
//  WorkoutCardViewModel.swift
//  funrun
//
//  Created by David Gunawan on 16/05/24.
//

import Foundation
import Combine

class WorkoutCardViewModel: ObservableObject {
    @Published var tracker: WorkoutTracker
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tracker: WorkoutTracker) {
        self.tracker = tracker
        
        tracker.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func toggleTracking() {
        tracker.toggleTracking()
    }
}
