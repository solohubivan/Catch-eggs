//
//  PlayerProfile.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import Foundation

struct PlayerProfile: Codable, Equatable {
    var name: String
    var coins: Int
    var avatarImageName: String
    var unlockedAvatars: Set<String>
    
    var unlockedLevels: Set<Int>
    var completedLevels: Set<Int>
    
    var settings: GameSettings
}

extension PlayerProfile {
    static let `default` = PlayerProfile(
        name: "Player",
        coins: 1000,
        avatarImageName: "",
        unlockedAvatars: ["freeAvatarGirl", "freeAvatarBoy"],
        unlockedLevels: [1],
        completedLevels: [],
        settings: .default
    )
}
