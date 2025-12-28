//
//  Catch_eggsApp.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 15.12.2025.
//

import SwiftUI

@main
struct CatchEggsApp: App {
    
    @StateObject private var session = GameSession(
        storage: UserDefaultsPlayerProfileStore(),
        leaderboardStore: UserDefaultsLeaderboardStore()
    )
    
    var body: some Scene {
        WindowGroup {
            StartScreenView()
                .environmentObject(session)
        }
    }
}
