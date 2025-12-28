//
//  LeaderboardEntry.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//
import SwiftUI

struct LeaderboardEntry: Identifiable, Codable, Equatable {
    let id: UUID
    let avatarImageName: String
    let name: String
    let score: Int

    init(id: UUID = UUID(), avatarImageName: String, name: String, score: Int) {
        self.id = id
        self.avatarImageName = avatarImageName
        self.name = name
        self.score = score
    }
}

extension LeaderboardEntry {
    static let mockTop: [LeaderboardEntry] = [
        .init(avatarImageName: "freeAvatarGirl", name: "Player", score: 100),
        .init(avatarImageName: "freeAvatarBoy",  name: "Ivan",   score: 200),
        .init(avatarImageName: "premiumAvatar1", name: "Alex",   score: 3),
        .init(avatarImageName: "premiumAvatar2", name: "Kate",   score: 4),
        .init(avatarImageName: "premiumAvatar3", name: "Max",    score: 3),
        .init(avatarImageName: "freeAvatarGirl", name: "Player", score: 2)

    ]
}
