//
//  ShopBoostersCatalog.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import Foundation

enum ShopBoostersCatalog {

    static let all: [ShopItem] = [
        .init(
            title: "Rescue Egg",
            subtitle: "Saves you when an egg falls",
            imageName: "magicEgg2",
            coinsPrice: 500
        ),
        .init(
            title: "Basket+",
            subtitle: "Makes basket wider for 10 minutes",
            imageName: "magicEgg3",
            coinsPrice: 350
        ),
        .init(
            title: "Frozen Time",
            subtitle: "All eggs fall slower for 10 seconds",
            imageName: "magicEgg4",
            coinsPrice: 200
        ),
        .init(
            title: "Double UP",
            subtitle: "Double points for each egg",
            imageName: "magicEgg1",
            coinsPrice: 500
        )
    ]
}
