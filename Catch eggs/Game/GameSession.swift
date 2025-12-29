//
//  GameSession.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 25.12.2025.
//

import Foundation
import Combine

final class GameSession: ObservableObject {

    @Published private(set) var profile: PlayerProfile
    @Published private(set) var leaderboard: [LeaderboardEntry]
    @Published var lastHighlightedEntryID: UUID?

    private let storage: PlayerProfileStoring
    private let leaderboardStore: LeaderboardStoring
    
    var bestScore: Int {
        leaderboard.map(\.score).max() ?? 0
    }

    init(storage: PlayerProfileStoring, leaderboardStore: LeaderboardStoring) {
        self.storage = storage
        self.leaderboardStore = leaderboardStore
        self.profile = storage.load()
        self.leaderboard = leaderboardStore.load()
        self.lastHighlightedEntryID = nil
    }
    
    @discardableResult
    func submitScore(_ score: Int, limit: Int = 15) -> Bool {
        let entry = LeaderboardEntry(
            avatarImageName: profile.avatarImageName,
            name: profile.name,
            score: score
        )

        var updated = leaderboard
        updated.append(entry)
        updated.sort { $0.score > $1.score }
        updated = Array(updated.prefix(limit))

        let didEnterTop = updated.contains(where: { $0.id == entry.id })

        leaderboard = updated
        leaderboardStore.save(updated)

        lastHighlightedEntryID = didEnterTop ? entry.id : nil

        return didEnterTop
    }

    func setName(_ name: String) {
        profile.name = name
        storage.save(profile)
    }

    func setAvatar(_ imageName: String) {
        profile.avatarImageName = imageName
        storage.save(profile)
    }

    func addCoins(_ amount: Int) {
        guard amount > 0 else { return }
        profile.coins += amount
        storage.save(profile)
    }

    @discardableResult
    func spendCoins(_ amount: Int) -> Bool {
        guard amount > 0, profile.coins >= amount else { return false }
        profile.coins -= amount
        storage.save(profile)
        return true
    }
    
    // MARK: - Premium avatars
    func isAvatarUnlocked(_ name: String) -> Bool {
        profile.unlockedAvatars.contains(name)
    }

    func unlockAvatar(_ name: String) {
        profile.unlockedAvatars.insert(name)
        storage.save(profile)
    }

    @discardableResult
    func purchaseAvatarIfNeeded(name: String, cost: Int) -> Bool {
        if isAvatarUnlocked(name) {
            setAvatar(name)
            return true
        }

        guard spendCoins(cost) else { return false }

        unlockAvatar(name)
        setAvatar(name)
        return true
    }
    
    func isLevelUnlocked(_ level: Int) -> Bool {
        profile.unlockedLevels.contains(level)
    }

    func markLevelCompleted(_ level: Int, maxLevel: Int = 9) {
        profile.completedLevels.insert(level)
        let next = level + 1
        if next <= maxLevel {
            profile.unlockedLevels.insert(next)
        }
        storage.save(profile)
    }
    
    func setSettings(_ settings: GameSettings) {
        profile.settings = settings
        storage.save(profile)
    }
}
