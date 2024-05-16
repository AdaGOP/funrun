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
    var title: String
    var sfSymbolImage: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tracker: WorkoutTracker, title: String, sfSymbolImage: String) {
        self.tracker = tracker
        self.title = title
        self.sfSymbolImage = sfSymbolImage
        
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
