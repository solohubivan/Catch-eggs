//
//  CoinsPack.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import Foundation

struct CoinsPack: Identifiable {
    let id: UUID
    let coinsAmount: Int
    let priceText: String
    let imageName: String

    init(
        id: UUID = UUID(),
        coinsAmount: Int,
        priceText: String,
        imageName: String
    ) {
        self.id = id
        self.coinsAmount = coinsAmount
        self.priceText = priceText
        self.imageName = imageName
    }
}
