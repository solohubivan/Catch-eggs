//
//  HowToPlayScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation
import Combine

final class HowToPlayScreenViewModel: ObservableObject {
    
    let titleText: String = "How to play"
    let mainRuleText: String = "Catch the eggs and become a champion!"
    let catchEggsRuleText: String = "Catch eggs to score points"
    let catchMagicEggsRuleText: String = "Magic eggs give more points"
    let catchSunRuleText: String = "Sun are safe and give bonus points"
    let catchBombsRuleText: String = "Bombs are dangerous — avoid them!"
    let scoringTitleText: String = "SCORING"
    let scoringNormalEgg: String = "Normal egg"
    let scoringMagicEgg: String = "Magic egg"
    let scoringSun: String = "Sun"
    let scoringBombCaught: String = "Bomb caught"
    let gameOverTitleText: String = "GAME OVER"
    let gameOverRuleText: String = "If 3 eggs fall and break, the game is over."
    let showYourSkilsText: String = "Show your skills and reach the top of the leaderboard!"
    let goodLuckText: String = "Good luck and have fun!"
}
