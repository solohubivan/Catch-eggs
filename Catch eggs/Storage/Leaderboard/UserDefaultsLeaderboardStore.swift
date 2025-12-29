//
//  UserDefaultsLeaderboardStore.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//
import Foundation

final class UserDefaultsLeaderboardStore: LeaderboardStoring {

    private let store = UserDefaultsCodableStore<[LeaderboardEntry]>(
        key: "leaderboard"
    )

    func load() -> [LeaderboardEntry] {
        store.load(default: LeaderboardEntry.mockTop)
    }

    func save(_ entries: [LeaderboardEntry]) {
        store.save(entries)
    }
}
