//
//  LeaderboardStoring.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

protocol LeaderboardStoring {
    func load() -> [LeaderboardEntry]
    func save(_ entries: [LeaderboardEntry])
}
