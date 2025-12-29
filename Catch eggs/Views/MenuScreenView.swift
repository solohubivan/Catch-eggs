//
//  MenuScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SwiftUI

struct MenuScreenView: View {
    
    @EnvironmentObject private var session: GameSession
    @StateObject private var viewModel = MenuScreenViewModel()
    
    @State private var showLevelsScreenView = false
    @State private var showProfile = false
    @State private var showSettings = false
    @State private var showLeaderboard = false
    @State private var showShop = false
    @State private var showHowToPlay = false
    
    private var currentScreen: MenuScreenViewModel.MainMenuRoute {
        if showProfile { return .profile }
        if showSettings { return .settings }
        if showLevelsScreenView { return .levels }
        if showLeaderboard { return .leaderboard }
        if showShop { return .shop }
        if showHowToPlay { return .howToPlay }
        return .menu
    }
    
    var body: some View {
        ZStack {
            backgroundImage
            screenView
        }
    }
    
    @ViewBuilder
    private var screenView: some View {
        switch currentScreen {
            case .profile:
                ProfileScreenView(isPresented: $showProfile)
            case .settings:
                SettingsScreenView(isPresented: $showSettings)
            case .levels:
                GameLevelsScreenView(isPresented: $showLevelsScreenView)
            case .leaderboard:
                LeaderboardScreenView(isPresented: $showLeaderboard)
            case .shop:
                ShopScreenView(isPresented: $showShop)
            case .howToPlay:
                HowToPlayScreenView(isPresented: $showHowToPlay)
            case .menu:
                mainMenu
        }
    }
    
    // MARK: - UI components
    private var backgroundImage: some View {
        Image("menuBackgroundImage")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var mainMenu: some View {
        VStack {
            topBar
            menuList
        }
    }
    
    private var topBar: some View {
        HStack {
            GoldCoinsView(amount: session.profile.coins)
        }
        .padding(.horizontal, 25)
    }
    
    private var menuList: some View {
        ZStack {
            AnimatedMenuCardBackground()
                
            VStack(spacing: 10) {
                Text(viewModel.titleText)
                    .font(.rubikMonoOne(.regular, size: 26))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                
                MenuButtonView(title: viewModel.playButtonTitleTxt) {
                    showLevelsScreenView = true
                }
                
                MenuButtonView(title: viewModel.profileButtonTitleTxt, fontSize: 18) {
                    showProfile = true
                }
                              
                MenuButtonView(title: viewModel.settingsButtonTitleTxt, fontSize: 16) {
                    showSettings = true
                }
                             
                MenuButtonView(title: viewModel.leaderboardsButtonTitleTxt, fontSize: 13) {
                    showLeaderboard = true
                }
                
                MenuButtonView(title: viewModel.shopButtonTitleTxt) {
                    showShop = true
                }
                
                MenuButtonView(title: viewModel.howToPlayButtonTitleTxt, fontSize: 18) {
                    showHowToPlay = true
                }
                                
                MenuButtonView(title: viewModel.exitButtonTitleTxt) {
                    
                }
            }
            .padding(.vertical, 25)
            .frame(maxWidth: 340)
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 30)
    }
}

#Preview("Menu") {
    let profileStore = UserDefaultsPlayerProfileStore()
    let leaderboardStore = UserDefaultsLeaderboardStore()

    let session: GameSession = GameSession(
        storage: profileStore,
        leaderboardStore: leaderboardStore
    )

    MenuScreenView()
        .environmentObject(session)
}
