//
//  HiitCardView.swift
//  funrun
//
//  Created by Haryanto Salim on 16/05/24.
//

import SwiftUI

struct HiitCardView: View {
    @ObservedObject var hiitModel: HIITTracker
    @Binding var isShowingDetails: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: hiitModel.sfSymbolImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .padding()
                
                if #available(iOS 17.0, *) {
                    Image(systemName: hiitModel.isTracking ? "stopwatch" : "stopwatch.fill")
                        .symbolEffect(.pulse, options: hiitModel.isTracking ? .repeating : .nonRepeating, value: hiitModel.isTracking)
                        .font(.title)
                        .padding()
                } else {
                    // Fallback on earlier versions
                }
                
                Button(action: {
                    hiitModel.toggleTracking()
                    if hiitModel.isTracking {
                        isShowingDetails = true
                        
                        //modify specific variable owned by the hiit model
                        hiitModel.addMovementSet(by: 1)
                    }
                }) {
                    Text(hiitModel.isTracking ? "Stop \(hiitModel.title)" : "Start \(hiitModel.title)")
                        .frame(width: 140)
                        .font(.headline)
                        .padding()
                        .background(hiitModel.isTracking ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Text(hiitModel.durationCounter.elapsedTime)
                .font(.title3)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .cardBackground()
    }
}
