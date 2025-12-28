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
    
    @State var showGame: Bool = false
    @State private var selectedLevel: Int = 1
    
    private let levels = Array(1...9)
    private let gridColumns: [GridItem] = Array(
        repeating: GridItem(.fixed(100), spacing: 16),
        count: 3
    )
    
    var body: some View {
        ZStack {
            screenView
        }
    }
    
    @ViewBuilder
    private var screenView: some View {
        if showGame {
            GameScreenView(level: selectedLevel)
                .transition(.opacity)
        } else {
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
    
    private var levelsButtons: some View {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(levels, id: \.self) { level in
                    levelCell(level)
                }
            }
            .padding(.top, -30)
        }

        private func levelCell(_ level: Int) -> some View {
            let unlocked = session.isLevelUnlocked(level)
            return Button {
                guard unlocked else { return }
                selectedLevel = level
                showGame = true
            } label: {
                ZStack {
                    Image("emptyUserImage")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)

                    Text("\(level)")
                        .font(.rubikMonoOne(.regular, size: 22))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)

                    if !unlocked {
                        lockOverlay
                    }
                }
            }
            .buttonStyle(.plain)
            .disabled(!unlocked)
            .opacity(unlocked ? 1 : 0.85)
        }

        private var lockOverlay: some View {
            ZStack {
                Color.black.opacity(0.45)
                Image(systemName: "lock.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(6)
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
        Text("CHANGE LEVEL")
            .font(.rubikMonoOne(.regular, size: 28))
            .foregroundStyle(.white)
    }
    
    @ViewBuilder
    private func menuButton(
        title: String,
        fontSize: CGFloat = 22,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack {
                Image("emptyUserImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                Text(title)
                    .font(.rubikMonoOne(.regular, size: fontSize))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)
                    .minimumScaleFactor(0.1)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    GameLevelsScreenView(isPresented: .constant(true))
}
