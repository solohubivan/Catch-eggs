//
//  GameSceneHolder.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 23.12.2025.
//

import SwiftUI
import SpriteKit
import Combine

final class GameSceneHolder: ObservableObject {

    @Published var score: Int = 0
    @Published var crashedEggs: Int = 0
    @Published var isPausedUI: Bool = false
    @Published var isGameOver: Bool = false
    @Published var timeLeft: Int = 0
    
    private var timer: Timer?
    private let totalTime: Int = 60
    
    lazy var gameScene: GameScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear

        scene.onCatch = { [weak self] kind in
            DispatchQueue.main.async {
                self?.score += kind.scoreDelta
            }
        }
        
        scene.onMiss = { [weak self] in
            DispatchQueue.main.async {
                self?.handleMiss()
            }
        }
        
        scene.onTimeOver = { [weak self] in
            DispatchQueue.main.async {
                self?.endGame()
            }
        }

        return scene
    }()
    
    func startLevel(_ level: Int) {
        score = 0
        crashedEggs = 0
        isGameOver = false
        isPausedUI = false

        gameScene.isPaused = false
        gameScene.createLevel(level)
        startTimer(totalTime)
    }
    
    func pauseGame() {
        isPausedUI = true
        gameScene.isPaused = true
        timer?.invalidate()
    }

    func resumeGame() {
        isPausedUI = false
        gameScene.resetTimingAfterPause()
        gameScene.isPaused = false
        startTimer(timeLeft)
    }
    
    func restartGame() {
        score = 0
        crashedEggs = 0
        isGameOver = false
        isPausedUI = false
        gameScene.isPaused = false
        gameScene.resetGame()
    }
    
    // MARK: - Private helpers
    private func handleMiss() {
        crashedEggs += 1

        if crashedEggs >= 3 {
            endGame()
        }
    }
    
    private func endGame() {
        isGameOver = true
        gameScene.isPaused = true
        timer?.invalidate()
    }
    
    private func startTimer(_ countFrom: Int) {
        timer?.invalidate()
        timeLeft = countFrom

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }

            self.timeLeft -= 1

            if self.timeLeft <= 0 {
                self.timer?.invalidate()
                self.endGame()
            }
        }
    }
}
