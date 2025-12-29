//
//  LeaderboardScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//

import SwiftUI

struct LeaderboardScreenView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject private var session: GameSession
    
    private var highlightedID: UUID? {
        session.lastHighlightedEntryID
    }
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack(spacing: 0) {
                headerBar
                leaderboardCard
            }
        }
    }
    
    private var backgroundImage: some View {
        Image("menuBackgroundImage")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var headerBar: some View {
        HStack {
            backButton
            Spacer()
        }
        .padding(.leading, 25)
    }
    
    private var backButton: some View {
        Button {
            isPresented = false
        } label: {
            Image("backButtonImage")
                .resizable()
                .frame(width: 80, height: 80)
        }
    }
    
    private var leaderboardCard: some View {
        ZStack {
            AnimatedMenuCardBackground()
            
            VStack(spacing: 0) {
                titleText
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                leaderboardList
            }
        }
        .padding(30)
    }
    
    private var titleText: some View {
        Text("LEADERBOARD")
            .font(.rubikMonoOne(.regular, size: 30))
            .foregroundColor(.white)
    }
    
    private var leaderboardList: some View {
        List {
            ForEach(session.leaderboard) { entry in
                LeaderboardRowView(
                    entry: entry,
                    isHighlighted: entry.id == highlightedID
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
            }
        }
        .listStyle(.plain)
        .background(Color.clear)
        .padding(.bottom, 10)
    }
}

#Preview {
    let session = GameSession(storage: UserDefaultsPlayerProfileStore(), leaderboardStore: UserDefaultsLeaderboardStore())
    LeaderboardScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
