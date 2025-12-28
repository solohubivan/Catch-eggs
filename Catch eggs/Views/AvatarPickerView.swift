//
//  AvatarPickerView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import SwiftUI

struct AvatarItem: Identifiable {
    let id = UUID()
    let imageName: String
    var isPremium: Bool { price != nil }
    let price: Int?
}

struct AvatarPickerView: View {

    @EnvironmentObject private var session: GameSession
    
    let selectedAvatar: String
    let onSelect: (String) -> Void
    
    @State private var pendingPurchase: AvatarItem?
    @State private var showPurchaseAlert = false
    @State private var showNotEnoughCoinsAlert = false

    private let avatars: [AvatarItem] = [
        .init(imageName: "freeAvatarGirl", price: nil),
        .init(imageName: "freeAvatarBoy", price: nil),

        .init(imageName: "premiumAvatar1", price: 100),
        .init(imageName: "premiumAvatar2", price: 100),
        .init(imageName: "premiumAvatar3", price: 100),
        .init(imageName: "premiumAvatar4", price: 100),
        .init(imageName: "premiumAvatar5", price: 100),
        .init(imageName: "premiumAvatar6", price: 100)
    ]
    
    private let columns = [
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
        .alert("Are u sure?", isPresented: $showPurchaseAlert) {
                    Button("Cancel", role: .cancel) { pendingPurchase = nil }
                    Button("Buy") { confirmPurchase() }
                } message: {
                    Text("Spend \(pendingPurchase?.price ?? 0) coins to unlock this avatar?")
                }
                .alert("Not enough coins", isPresented: $showNotEnoughCoinsAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("You don’t have enough coins to buy this avatar.")
                }
    }
    
    private var availableGoldCoins: some View {
        GoldCoinsView(amount: session.profile.coins)
    }
    
    private var avatarsGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(avatars) { avatar in
                avatarCell(avatar)
            }
        }
    }
    
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

    private func avatarCell(_ avatar: AvatarItem) -> some View {
            let isUnlocked = !avatar.isPremium || session.isAvatarUnlocked(avatar.imageName)

            return Button {
                if isUnlocked {
                    session.setAvatar(avatar.imageName)
                    onSelect(avatar.imageName)
                    return
                }

                pendingPurchase = avatar
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
    
    private func confirmPurchase() {
            guard let avatar = pendingPurchase, let cost = avatar.price else { return }

            let success = session.purchaseAvatarIfNeeded(name: avatar.imageName, cost: cost)
            pendingPurchase = nil

            if success {
                onSelect(avatar.imageName)
            } else {
                showNotEnoughCoinsAlert = true
            }
        }
}

//#Preview {
//    AvatarPickerView(
//        selectedAvatar: "freeAvatarGirl",
////        onSelect: { avatar in
////            print("Selected avatar:", avatar)
////        }
//        onSelect: { _ in }
//    )
//}
