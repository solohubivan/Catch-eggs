//
//  PlayerProfileStorage.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import Foundation

final class UserDefaultsPlayerProfileStore: PlayerProfileStoring {

    private let store = UserDefaultsCodableStore<PlayerProfile>(
        key: "playerProfile"
    )

    func load() -> PlayerProfile {
        store.load(default: .default)
    }

    func save(_ profile: PlayerProfile) {
        store.save(profile)
    }

    func update(_ mutate: (inout PlayerProfile) -> Void) -> PlayerProfile {
        var profile = load()
        mutate(&profile)
        save(profile)
        return profile
    }
}
