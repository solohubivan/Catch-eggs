//
//  PlayerProfileStoring.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

protocol PlayerProfileStoring {
    func load() -> PlayerProfile
    func save(_ profile: PlayerProfile)
    func update(_ mutate: (inout PlayerProfile) -> Void) -> PlayerProfile
}
