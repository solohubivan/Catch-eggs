//
//  ContentView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 15.12.2025.
//

import SwiftUI
import SpriteKit

struct GameScreenView: View {

    let level: Int

    @EnvironmentObject private var session: GameSession

    @StateObject private var holder: GameSceneHolder
    @StateObject private var viewModel: GameScreenViewModel

    @State private var showMainMenu: Bool = false
    @State private var showGameLevels: Bool = false
    
    init(level: Int) {
        self.level = level
        let holder = GameSceneHolder()
        _holder = StateObject(wrappedValue: holder)
        _viewModel = StateObject(wrappedValue: GameScreenViewModel(holder: holder))
    }

    var body: some View {
        ZStack {
            gameLayer
            overlaysLayer
            if viewModel.isGameActive {
                hudLayer
            }
        }
        .onAppear {
            viewModel.startLevel(level)
        }
        .onChange(of: holder.crashedEggs) { newValue in
            viewModel.handleCrashedEggsChange(newValue)
        }
        .fullScreenCover(isPresented: $showMainMenu) {
            MenuScreenView()
        }
        .fullScreenCover(isPresented: $showGameLevels) {
            GameLevelsScreenView(isPresented: $showGameLevels)
        }
    }

    // MARK: - Layers
    private var gameLayer: some View {
        SpriteView(scene: holder.gameScene, options: [.ignoresSiblingOrder])
            .ignoresSafeArea()
    }

    private var hudLayer: some View {
        ZStack {
            VStack {
                topBar
                brokenEggsRow
            }
            controls
        }
    }

    private var brokenEggsRow: some View {
        HStack(alignment: .center, spacing: 0) {
            brokenEggsView
        }
        .padding(.horizontal, 25)
    }

    @ViewBuilder
    private var brokenEggsView: some View {
        let count = min(max(holder.crashedEggs, 0), 2)

        if count >= 1 { brokenEggImage }
        if count >= 2 { brokenEggImage }
    }

    private var brokenEggImage: some View {
        Image("brokenEgg")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
    }

    @ViewBuilder
    private var overlaysLayer: some View {
        if holder.isPausedUI {
            pausedOverlay
        }

        if holder.isGameOver {
            resultsOverlay
        }
    }

    // MARK: - Overlays
    private var pausedOverlay: some View {
        PausedGameView(
            onResume: animate {
                holder.resumeGame()
            },
            onRestart: animate {
                viewModel.restartLevel(level)
            },
            onHome: animate {
                showMainMenu = true
            }
        )
    }

    private var resultsOverlay: some View {
        ResultsGameView(
            state: viewModel.finishState,
            score: holder.score,
            bestScore: session.bestScore,
            onRestart: animate {
                viewModel.restartLevel(level)
            },
            onHome: animate {
                showMainMenu = true
            },
            onNext: animate {
                if viewModel.finishState == .win {
                    session.markLevelCompleted(level)
                }
                showGameLevels = true
            }
        )
        .onAppear {
            viewModel.submitScoreIfNeeded(score: holder.score) { score in
                _ = session.submitScore(score)
            }
        }
        .transition(.opacity)
    }

    // MARK: - UI components
    private var topBar: some View {
        HStack {
            infoTexts
            Spacer()
            GoldCoinsView(amount: session.profile.coins)
            Spacer()
            pauseButton
        }
        .padding(.horizontal, 25)
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private var infoTexts: some View {
        VStack(alignment: .leading) {
            Text("Score: \(holder.score)")
            Text("Time left: \(holder.timeLeft)")
        }
        .font(.system(size: 18, weight: .bold))
        .foregroundStyle(.white)
    }

    private var pauseButton: some View {
        Button {
            holder.pauseGame()
        } label: {
            Image("pauseImage")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
        }
    }

    private var controls: some View {
        HStack {
            holdButton(
                systemName: "arrow.left.circle",
                onPress: {
                    holder.gameScene.setMoveDirection(-1)
                },
                onRelease: {
                    holder.gameScene.setMoveDirection(0)
                }
            )

            Spacer()

            holdButton(
                systemName: "arrow.right.circle",
                onPress: { holder.gameScene.setMoveDirection(1) },
                onRelease: { holder.gameScene.setMoveDirection(0) }
            )
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 30)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    // MARK: - Private helpers (UI-only)
    private func holdButton(
        systemName: String,
        onPress: @escaping () -> Void,
        onRelease: @escaping () -> Void
    ) -> some View {
        Image(systemName: systemName)
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundStyle(.white)
            .onLongPressGesture(
                minimumDuration: 0,
                maximumDistance: 50,
                pressing: { pressing in
                    pressing ? onPress() : onRelease()
                },
                perform: {}
            )
    }

    private func animate(_ action: @escaping () -> Void) -> () -> Void {
        { withAnimation(.easeOut(duration: 0.25)) { action() } }
    }
}

#Preview("GameScreen") {
    let profileStore = UserDefaultsPlayerProfileStore()
    let leaderboardStore = UserDefaultsLeaderboardStore()

    let session: GameSession = GameSession(
        storage: profileStore,
        leaderboardStore: leaderboardStore
    )

    GameScreenView(level: 1)
        .environmentObject(session)
}
