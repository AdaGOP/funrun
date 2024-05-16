//
//  HiitDetailView.swift
//  funrun
//
//  Created by Haryanto Salim on 16/05/24.
//

import SwiftUI

struct HiitDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var hiitModel: HIITTracker
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Text(hiitModel.title)
                .font(.title)
            Group {
                HStack {
                    VStack {
                        if #available(iOS 17.0, *) {
                            Image(systemName: hiitModel.isTracking ? "stopwatch" : "stopwatch.fill")
                                .resizable()
                                .symbolEffect(.pulse, options: .repeating, value: hiitModel.isAnimating)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(hiitModel.durationCounter.elapsedTime)
                            .font(.title3)
                    }
                    VStack(alignment: .leading) {
                        //display specific view based on the provided data owned by the hiit model
                        ForEach(hiitModel.movementSet.keys.sorted(), id: \.self) { movementKey in
                            Text("\(MovementMetric(movement: movementKey, numOfSet: hiitModel.movementSet[movementKey] ?? 0, unit: "set"))")
                        }
                        
                        Button(action: {
                            hiitModel.toggleTracking()
                            dismiss()
                        }) {
                            Text(hiitModel.isTracking ? "Stop Tracking" : "Start Tracking")
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
                hiitModel.isAnimating.toggle()
            }
            .onDisappear {
                hiitModel.isAnimating.toggle()
            }
        }
    }
}

