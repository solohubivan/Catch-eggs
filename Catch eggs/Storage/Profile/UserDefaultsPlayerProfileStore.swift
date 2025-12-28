//
//  PlayerProfileStorage.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import Foundation

final class UserDefaultsPlayerProfileStore: PlayerProfileStoring {

    private let defaults: UserDefaults
    private let key: String

    init(defaults: UserDefaults = .standard, key: String = "playerProfile") {
        self.defaults = defaults
        self.key = key
    }

    func load() -> PlayerProfile {
        guard
            let data = defaults.data(forKey: key),
            let profile = try? JSONDecoder().decode(PlayerProfile.self, from: data)
        else { return .default }
        return profile
    }

    func save(_ profile: PlayerProfile) {
        guard let data = try? JSONEncoder().encode(profile) else { return }
        defaults.set(data, forKey: key)
    }

    func update(_ mutate: (inout PlayerProfile) -> Void) -> PlayerProfile {
        var profile = load()
        mutate(&profile)
        save(profile)
        return profile
    }
}
