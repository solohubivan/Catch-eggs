//
//  AvatarPickerViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation
import Combine

@MainActor
final class AvatarPickerViewModel: ObservableObject {

    @Published var pendingPurchase: AvatarItem?
    
    let alertTitleAreUsure: String = "Are you sure?"
    let cancelButtonTitle: String = "Cancel"
    let buyButtonTitle: String = "Buy"
    let alertTitleNotEnoughCoins: String = "Not enough coins"
    let okButtonTitle: String = "Ok"
    let alertMessageNotEnoughCoins: String = "You don’t have enough coins to buy this avatar."
    
    var purchaseMessage: String {
        let price = pendingPurchase?.price ?? 0
        return "Spend \(price) coins to unlock this avatar?"
    }

    func confirmPurchase(
        session: GameSession,
        showNotEnoughCoinsAlert: inout Bool,
        onSelect: (String) -> Void
    ) {
        guard let avatar = pendingPurchase, let cost = avatar.price else { return }

        let success = session.purchaseAvatarIfNeeded(name: avatar.imageName, cost: cost)
        pendingPurchase = nil

        if success {
            onSelect(avatar.imageName)
        } else {
            showNotEnoughCoinsAlert = true
        }
    }
}
