//
//  AnimatedMenuCardBackground.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import SwiftUI

struct AnimatedMenuCardBackground: View {

    var cornerRadius: CGFloat = 12
    var fillOpacity: CGFloat = 0.95
    var borderOpacity: CGFloat = 0.9
    var borderLineWidth: CGFloat = 2

    @State private var progress: CGFloat = 0

    var body: some View {
        ZStack {
            cardBackground
            border
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: [
                        Color.mainMenuBackground.opacity(fillOpacity),
                        Color.mainManuBorder.opacity(0.6)
                    ],
                    startPoint: UnitPoint(
                        x: -1.2 + progress,
                        y: -1.2 + progress
                    ),
                    endPoint: UnitPoint(
                        x: 2.2 + progress,
                        y: 2.2 + progress
                    )
                )
            )
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(Color.mainManuBorder.opacity(borderOpacity), lineWidth: borderLineWidth)
    }

    private func startAnimation() {
        progress = 0
        withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
            progress = 1.5
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AnimatedMenuCardBackground()
            .frame(height: 300)
            .padding()
    }
}
