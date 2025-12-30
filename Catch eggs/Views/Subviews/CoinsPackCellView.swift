//
//  CoinsPackCellView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import SwiftUI

struct CoinsPackCellView: View {
    
    let pack: CoinsPack
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                background
                goldImage
                priceInformation
            }
        }
        .buttonStyle(.plain)
        .frame(height: 110)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.mainMenuBackground.opacity(0.9))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.mainManuBorder, lineWidth: 2)
            )
    }
    
    private var goldImage: some View {
        Image(pack.imageName)
            .resizable()
            .scaledToFit()
    }
    
    private var priceInformation: some View {
        VStack {
            Text("\(pack.coinsAmount)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            Text(pack.priceText)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.yellow)
        }
        .padding(.vertical, 8)
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
