//
//  PausedGameView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import SwiftUI

struct PausedGameView: View {

    let onResume: () -> Void
    let onRestart: () -> Void
    let onHome: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)

            VStack {
                title
                navigationButtons
                    .padding(.horizontal, 50)
                    .padding(.top, 16)
                playButton
                    .padding(.top, 40)
            }
        }
        .ignoresSafeArea()
        .transition(.opacity)
    }

    private var title: some View {
        Text("PAUSED")
            .font(.rubikMonoOne(.regular, size: 55))
            .foregroundColor(.white)
    }

    private var navigationButtons: some View {
        HStack {
            Button(action: onHome) {
                Text("HOME")
                    .font(.rubikMonoOne(.regular, size: 28))
                    .foregroundStyle(.white)
                    .underline()
            }

            Spacer()

            Button(action: onRestart) {
                Text("RESTART")
                    .font(.rubikMonoOne(.regular, size: 28))
                    .foregroundStyle(.white)
                    .underline()
            }
        }
    }

    private var playButton: some View {
        Button(action: onResume) {
            Image("playButtonImage")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
        }
    }
}

#Preview {
    PausedGameView(
        onResume: {},
        onRestart: {},
        onHome: {}
    )
}
