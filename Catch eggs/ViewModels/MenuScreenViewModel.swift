//
//  MenuScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import Foundation
import Combine

final class MenuScreenViewModel: ObservableObject {
    
    enum MainMenuRoute {
        case menu, profile, settings, levels, leaderboard, shop, howToPlay
    }
    
    let titleText: String = "MENU"
    let playButtonTitleTxt: String = "PLAY"
    let profileButtonTitleTxt: String = "PROFILE"
    let settingsButtonTitleTxt: String = "SETTINGS"
    let leaderboardsButtonTitleTxt: String = "LEADERBOARD"
    let shopButtonTitleTxt: String = "SHOP"
    let howToPlayButtonTitleTxt: String = "HOW TO\nPLAY"
    let exitButtonTitleTxt: String = "EXIT"
}
