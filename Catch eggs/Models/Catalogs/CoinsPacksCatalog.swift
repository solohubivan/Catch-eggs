//
//  CoinsPacksCatalog.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import Foundation

enum CoinsPacksCatalog {

    static let all: [CoinsPack] = [
        .init(
            coinsAmount: 100,
            priceText: "$5",
            imageName: "100goldcoins"
        ),
        .init(
            coinsAmount: 500,
            priceText: "$10",
            imageName: "500goldcoins"
        ),
        .init(
            coinsAmount: 1000,
            priceText: "$12",
            imageName: "1000goldcoins"
        )
    ]
}
