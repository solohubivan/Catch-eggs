//
//  GameSettings.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//

import Foundation

struct GameSettings: Codable, Equatable {
    var soundEnabled: Bool
    var notificationsEnabled: Bool
    var vibrationEnabled: Bool
}

extension GameSettings {
    static let `default` = GameSettings(
        soundEnabled: true,
        notificationsEnabled: true,
        vibrationEnabled: true
    )
}
