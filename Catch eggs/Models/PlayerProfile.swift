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
        avatarImageName: "emptyUserImage",
        unlockedAvatars: ["freeAvatarGirl", "freeAvatarBoy"],
        unlockedLevels: [1],
        completedLevels: [],
        settings: .default
    )
}


//extension PlayerProfile {
//    enum CodingKeys: String, CodingKey {
//        case name, coins, avatarImageName, unlockedAvatars
//        case unlockedLevels, completedLevels
//        case settings
//    }
//
//    init(from decoder: Decoder) throws {
//        let c = try decoder.container(keyedBy: CodingKeys.self)
//
//        name = try c.decodeIfPresent(String.self, forKey: .name) ?? PlayerProfile.default.name
//        coins = try c.decodeIfPresent(Int.self, forKey: .coins) ?? PlayerProfile.default.coins
//        avatarImageName = try c.decodeIfPresent(String.self, forKey: .avatarImageName) ?? PlayerProfile.default.avatarImageName
//        unlockedAvatars = try c.decodeIfPresent(Set<String>.self, forKey: .unlockedAvatars) ?? PlayerProfile.default.unlockedAvatars
//
//        unlockedLevels = try c.decodeIfPresent(Set<Int>.self, forKey: .unlockedLevels) ?? PlayerProfile.default.unlockedLevels
//        completedLevels = try c.decodeIfPresent(Set<Int>.self, forKey: .completedLevels) ?? PlayerProfile.default.completedLevels
//
//        settings = try c.decodeIfPresent(GameSettings.self, forKey: .settings) ?? .default
//    }
//}
