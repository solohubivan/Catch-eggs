//
//  SettingsScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation
import Combine

@MainActor
final class SettingsScreenViewModel: ObservableObject {

    @Published var soundEnabled: Bool = true
    @Published var notificationsEnabled: Bool = true
    @Published var vibrationEnabled: Bool = true
    
    let settingsTitleText: String = "SETTINGS"
    let soundText: String = "SOUND"
    let notificationText: String = "NOTIFICATION"
    let vibrationText: String = "VIBRATION"

    func load(from session: GameSession) {
        let s = session.profile.settings
        soundEnabled = s.soundEnabled
        notificationsEnabled = s.notificationsEnabled
        vibrationEnabled = s.vibrationEnabled
    }

    func save(to session: GameSession) {
        let newSettings = GameSettings(
            soundEnabled: soundEnabled,
            notificationsEnabled: notificationsEnabled,
            vibrationEnabled: vibrationEnabled
        )
        session.setSettings(newSettings)
    }
}
