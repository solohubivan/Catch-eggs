//
//  UserDefaultsLeaderboardStore.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//
import Foundation

final class UserDefaultsLeaderboardStore: LeaderboardStoring {
    private let defaults: UserDefaults
    private let key: String

    init(defaults: UserDefaults = .standard, key: String = "leaderboard") {
        self.defaults = defaults
        self.key = key
    }

    func load() -> [LeaderboardEntry] {
        guard
            let data = defaults.data(forKey: key),
            let entries = try? JSONDecoder().decode([LeaderboardEntry].self, from: data)
        else {
            return LeaderboardEntry.mockTop
        }
        return entries
    }

    func save(_ entries: [LeaderboardEntry]) {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        defaults.set(data, forKey: key)
    }
}
