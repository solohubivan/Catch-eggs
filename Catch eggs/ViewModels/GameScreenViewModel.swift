//
//  GameScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import SwiftUI
import Combine

@MainActor
final class GameScreenViewModel: ObservableObject {

    let holder: GameSceneHolder

    private var lastCrashedEggs: Int = 0
    private var didSubmitScore: Bool = false

    init(holder: GameSceneHolder) {
        self.holder = holder
    }
    
    var finishState: GameFinishState {
        holder.crashedEggs < 3 ? .win : .lose
    }

    var isGameActive: Bool {
        !holder.isPausedUI && !holder.isGameOver
    }
    
    func startLevel(_ level: Int) {
        didSubmitScore = false
        holder.startLevel(level)
        lastCrashedEggs = holder.crashedEggs
    }

    func restartLevel(_ level: Int) {
        didSubmitScore = false
        holder.restartGame()
        holder.startLevel(level)
        lastCrashedEggs = holder.crashedEggs
    }
    
    func handleCrashedEggsChange(_ newValue: Int) {
        guard newValue > lastCrashedEggs, newValue <= 2 else {
            lastCrashedEggs = newValue
            return
        }
        playBrokenEggHaptic()
        lastCrashedEggs = newValue
    }
    
    func submitScoreIfNeeded(score: Int, submit: (Int) -> Void) {
        guard !didSubmitScore else { return }
        submit(score)
        didSubmitScore = true
    }

    private func playBrokenEggHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
