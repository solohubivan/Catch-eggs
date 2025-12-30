//
//  ShopItemCardView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//
import SwiftUI

struct ShopItemCardView: View {

    let item: ShopItem
    let onBuy: () -> Void

    var body: some View {
        ZStack {
            background

            HStack(spacing: 14) {
                itemImage
                itemNameAndDescription
                Spacer()
                itemPriceAndBuy
            }
            .padding(16)
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.mainMenuBackground.opacity(0.75))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.mainManuBorder.opacity(0.9), lineWidth: 2)
            )
    }
    
    private var itemImage: some View {
        Image(item.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
    }
    
    private var itemNameAndDescription: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.title)
                .font(.rubikMonoOne(.regular, size: 18))
                .foregroundStyle(.white)

            Text(item.subtitle)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.9))
                .lineLimit(2)
        }
    }
    
    private var itemPriceAndBuy: some View {
        VStack(spacing: 8) {
            Text("\(item.coinsPrice)")
                .font(.system(size: 18, weight: .heavy))
                .foregroundStyle(.yellow)

            Button(action: onBuy) {
                Text("BUY")
                    .font(.rubikMonoOne(.regular, size: 14))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green.opacity(0.9))
                    )
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    let session = GameSession(
        storage: UserDefaultsPlayerProfileStore(),
        leaderboardStore: UserDefaultsLeaderboardStore()
    )

    ShopScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
