//
//  CircleSwitch.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//

import SwiftUI

struct CircleSwitch: View {

    @Binding var isOn: Bool

    var height: CGFloat = 32

    private var width: CGFloat { height * 2 }
    private var knobSize: CGFloat { height - 3 }
    private var padding: CGFloat { (height - knobSize) / 2 }

    private var onBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.switchGreenLight,
                Color.switchGreenDark
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var offBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.switchGreyLight,
                Color.switchGreyDark
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.22, dampingFraction: 0.85)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(isOn ? AnyShapeStyle(onBackgroundGradient) : AnyShapeStyle(offBackgroundGradient))
                    .frame(width: width, height: height)
                Circle()
                    .fill(Color.white)
                    .frame(width: knobSize, height: knobSize)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                    .padding(padding)
            }
        }
        .buttonStyle(.plain)
    }
}
