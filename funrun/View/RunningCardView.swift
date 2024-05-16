//
//  RunningCardView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct RunningCardView: View {
    @ObservedObject var runningModel: RunningTracker
    @Binding var isShowingDetails: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: runningModel.sfSymbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: runningModel.isTracking ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: runningModel.isTracking ? .repeating : .nonRepeating, value: runningModel.isTracking)
                        .font(.title)
                        .padding()
                } else {
                    // Fallback on earlier versions
                }
                
                Button(action: {
                    runningModel.toggleTracking()
                    if runningModel.isTracking {
                        isShowingDetails = true
                        
                        //modify specific variable owned by the running model
                        runningModel.addDistance(by: 1.5)
                    }
                }) {
                    Text(runningModel.isTracking ? "Stop \(runningModel.title)" : "Start \(runningModel.title)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(runningModel.isTracking ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Text(runningModel.durationCounter.elapsedTime)
                .font(.title3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .cardBackground()
    }
}
