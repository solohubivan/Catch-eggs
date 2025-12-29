//
//  ResultsGameView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import SwiftUI

struct ResultsGameView: View {
    
    let state: GameFinishState
    let score: Int
    let bestScore: Int
    let onRestart: () -> Void
    let onHome: () -> Void
    let onNext: () -> Void
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            
            VStack {
                title
                results
                navigationButtons
                    .padding(.horizontal, 45)
                    .padding(.top, 16)
                nextButton
                    .padding(.top, 30)
            }
        }
        .ignoresSafeArea()
        .transition(.opacity)
    }
    
    private var title: some View {
        Text(state.titleText)
            .font(.rubikMonoOne(.regular, size: 43))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
    }
    
    private var results: some View {
            VStack {
                resultRow(title: "SCORE", value: score)
                resultRow(title: "BEST", value: bestScore)
            }
        }

        private func resultRow(title: String, value: Int) -> some View {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green)
                    .frame(height: 55)
                    .padding(.horizontal, 30)

                Text("\(title) \(value.formatted(.number.grouping(.never)))")
                    .font(.rubikMonoOne(.regular, size: 25))
                    .foregroundColor(.white)
            }
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
    
    @ViewBuilder
    private var nextButton: some View {
        switch state {
        case .win:
            MenuButtonView(title: "NEXT") {
                onNext()
            }
            .padding(.horizontal, 60)

        case .lose:
            MenuButtonView(title: "TRY AGAIN") {
                onRestart()
            }
            .padding(.horizontal, 60)
        }
    }
}

#Preview {
    ResultsGameView(
        state: .win,
//        state: .lose,
        score: 1234,
        bestScore: 2500,
        onRestart: {},
        onHome: {},
        onNext: {}
    )
}


enum GameFinishState {
    case win
    case lose

    var titleText: String {
        switch self {
        case .win:  return "YOU WIN!"
        case .lose: return "YOU LOSE!"
        }
    }
}
