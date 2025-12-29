//
//  AvatarPickerView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import SwiftUI

struct AvatarPickerView: View {
    
    let selectedAvatar: String
    let onSelect: (String) -> Void

    @EnvironmentObject private var session: GameSession
    @StateObject private var viewModel = AvatarPickerViewModel()

    @State private var showPurchaseAlert = false
    @State private var showNotEnoughCoinsAlert = false

    private let avatars = AvatarCatalog.all
    
    private let gridsColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color.mainMenuBackground.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                availableGoldCoins
                avatarsGrid
                
            }
            .padding(.top, -70)
            .padding(30)
        }
        .alert(viewModel.alertTitleAreUsure, isPresented: $showPurchaseAlert) {
            Button(viewModel.cancelButtonTitle, role: .cancel) {
                viewModel.pendingPurchase = nil
            }
            
            Button(viewModel.buyButtonTitle) {
                viewModel.confirmPurchase(
                    session: session,
                    showNotEnoughCoinsAlert: &showNotEnoughCoinsAlert,
                    onSelect: onSelect
                )
            }
        } message: {
            Text(viewModel.purchaseMessage)
        }
        
        .alert(viewModel.alertTitleNotEnoughCoins, isPresented: $showNotEnoughCoinsAlert) {
            Button(viewModel.okButtonTitle, role: .cancel) { }
        } message: {
            Text(viewModel.alertMessageNotEnoughCoins)
        }
    }
    
    // MARK: - UI components
    private var availableGoldCoins: some View {
        GoldCoinsView(amount: session.profile.coins)
    }
    
    private var avatarsGrid: some View {
        LazyVGrid(columns: gridsColumns, spacing: 20) {
            ForEach(avatars) { avatar in
                avatarItemCell(avatar)
            }
        }
    }
    
    // MARK: - private helpers
    private func premiumOverlay(price: Int) -> some View {
        ZStack {
            Color.black.opacity(0.45)

            VStack(spacing: 6) {
                Image(systemName: "lock.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)

                Text("\(price)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.yellow)
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(6)
    }

    private func avatarItemCell(_ avatar: AvatarItem) -> some View {
        let isUnlocked = !avatar.isPremium || session.isAvatarUnlocked(avatar.imageName)

        return Button {
            if isUnlocked {
                session.setAvatar(avatar.imageName)
                onSelect(avatar.imageName)
                return
            }

            viewModel.pendingPurchase = avatar
            showPurchaseAlert = true
        } label: {
            Image("emptyUserImage")
                .resizable()
                .scaledToFit()
                .overlay {
                    ZStack {
                        Image(avatar.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(20)

                        if avatar.isPremium && !isUnlocked {
                            premiumOverlay(price: avatar.price ?? 0)
                        }
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let profileStore = UserDefaultsPlayerProfileStore()
    let leaderboardStore = UserDefaultsLeaderboardStore()

    let session: GameSession = GameSession(
        storage: profileStore,
        leaderboardStore: leaderboardStore
    )
    AvatarPickerView(
        selectedAvatar: "freeAvatarGirl",
        onSelect: {_ in }
    )
    .environmentObject(session)
}
