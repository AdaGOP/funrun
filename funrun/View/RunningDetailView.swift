//
//  RunningDetailView.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

struct RunningDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var runningModel: RunningTracker
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Text(runningModel.title)
                .font(.title)
            Group {
                HStack {
                    VStack {
                        if #available(iOS 17.0, *) {
                            Image(systemName: runningModel.isTracking ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: runningModel.isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(runningModel.durationCounter.elapsedTime)
                            .font(.title3)
                    }
                    VStack(alignment: .leading) {
                        //display specific view based on the provided data owned by the running model
                        Text("\(DistanceMetric(name: "Distance", value: runningModel.distanceInKm, unit: "km"))")
                        
                        Button(action: {
                            runningModel.toggleTracking()
                            dismiss()
                        }) {
                            Text(runningModel.isTracking ? "Stop Tracking" : "Start Tracking")
                                .font(.headline)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .onAppear {
                runningModel.isAnimating.toggle()
            }
            .onDisappear {
                runningModel.isAnimating.toggle()
            }
        }
    }
}
