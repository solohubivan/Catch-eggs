//
//  GameLevelsScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import Foundation
import Combine

final class GameLevelsScreenViewModel: ObservableObject {
    
    @Published var selectedLevel: Int = 1
 
    let levels: [Int]
    let titletext: String = "CHANGE LEVEL"

    init(levels: [Int] = Array(1...9)) {
        self.levels = levels
    }

    func select(level: Int) {
        selectedLevel = level
    }
}
