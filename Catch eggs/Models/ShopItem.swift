//
//  ShopItem.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import Foundation

struct ShopItem: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageName: String
    let coinsPrice: Int

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        imageName: String,
        coinsPrice: Int
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.coinsPrice = coinsPrice
    }
}
