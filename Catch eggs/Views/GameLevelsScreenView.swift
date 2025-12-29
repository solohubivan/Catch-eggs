//
//  LevelGameScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 19.12.2025.
//

import SwiftUI

struct GameLevelsScreenView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject private var session: GameSession
    @StateObject private var viewModel = GameLevelsScreenViewModel()
    @State var showGame: Bool = false
    
    private let gridColumns: [GridItem] = Array(
        repeating: GridItem(.fixed(100), spacing: 16),
        count: 3
    )
    
    var body: some View {
        ZStack {
            if showGame {
                GameScreenView(level: viewModel.selectedLevel)
                    .transition(.opacity)
            } else {
                levelsView
            }
        }
    }
    
    // MARK: - UI elements
    private var levelsView: some View {
        ZStack {
            backgroundImage
            
            VStack {
                topBar
                titleText
                Spacer()
                levelsButtons
                Spacer()
            }
        }
    }
    
    private var backgroundImage: some View {
        Image("menuBackgroundImage")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var topBar: some View {
        HStack {
            backButton
            Spacer()
            GoldCoinsView(amount: session.profile.coins)
        }
        .padding(.horizontal, 25)
    }
    
    private var backButton: some View {
        Button {
            isPresented = false
        } label: {
            Image("backButtonImage")
                .resizable()
                .frame(width: 80, height: 80)
        }
    }
    
    private var titleText: some View {
        Text(viewModel.titletext)
            .font(.rubikMonoOne(.regular, size: 28))
            .foregroundStyle(.white)
    }
    
    private var levelsButtons: some View {
        LazyVGrid(columns: gridColumns, spacing: 16) {
            ForEach(viewModel.levels, id: \.self) { level in
                configureLevelButton(level)
            }
        }
        .padding(.top, -30)
    }
    
    private var lockOverlay: some View {
        ZStack {
            Color.black.opacity(0.45)

            Image(systemName: "lock.fill")
                .font(.title)
                .foregroundColor(.yellow)
                .shadow(radius: 2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(6)
    }
    
    // MARK: - Private helper
    private func configureLevelButton(_ level: Int) -> some View {
        let unlocked = session.isLevelUnlocked(level)

        return Button {
            guard unlocked else { return }
            viewModel.select(level: level)
            showGame = true
        } label: {
            ZStack {
                Image("emptyUserImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)

                if unlocked {
                    Text("\(level)")
                        .font(.rubikMonoOne(.regular, size: 22))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)
                } else {
                    lockOverlay
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(!unlocked)
        .opacity(unlocked ? 1 : 0.85)
    }
}

#Preview {
    let defaults = UserDefaults(suiteName: "previewGameLevels")!

    let profileStore = UserDefaultsPlayerProfileStore(defaults: defaults)
    let leaderboardStore = UserDefaultsLeaderboardStore(defaults: defaults)

    let session: GameSession = GameSession(
        storage: profileStore,
        leaderboardStore: leaderboardStore
    )
    GameLevelsScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
