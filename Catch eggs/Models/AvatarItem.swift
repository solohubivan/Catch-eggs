//
//  AvatarItem.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation

struct AvatarItem: Identifiable, Codable, Equatable {
    let id: UUID
    let imageName: String
    let price: Int?

    init(id: UUID = UUID(), imageName: String, price: Int? = nil) {
        self.id = id
        self.imageName = imageName
        self.price = price
    }

    var isPremium: Bool { price != nil }
}
