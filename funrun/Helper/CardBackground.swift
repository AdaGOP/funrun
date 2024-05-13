//
//  CardBackground.swift
//  funrun
//
//  Created by David Gunawan on 13/05/24.
//

import SwiftUI

// View modifier
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
                    .shadow(radius: 1)
            )
            .padding([.top, .horizontal])
    }
}

extension View {
    func cardBackground() -> some View {
        modifier(CardBackground())
    }
}
