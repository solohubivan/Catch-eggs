//
//  ShopScreenViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 31.12.2025.
//

import SwiftUI
import Combine

@MainActor
final class ShopScreenViewModel: ObservableObject {
    
    let boosters: [ShopItem]
    let coinsPacks: [CoinsPack]

    @Published var pendingBuyItem: ShopItem?
    @Published var selectedCoinsPack: CoinsPack?

    @Published var showConfirmBuyAlert = false
    @Published var showNotEnoughCoinsAlert = false
    @Published var showSuccessAlert = false
    @Published var showCoinsSuccessAlert = false

    init(
        boosters: [ShopItem]? = nil,
        coinsPacks: [CoinsPack]? = nil
    ) {
        self.boosters = boosters ?? ShopBoostersCatalog.all
        self.coinsPacks = coinsPacks ?? CoinsPacksCatalog.all
    }

    // MARK: - Actions
    func buyCoinsPackTapped(_ pack: CoinsPack) {
        selectedCoinsPack = pack
    }

    func paymentConfirmed(session: GameSession) {
        guard let pack = selectedCoinsPack else { return }
        session.addCoins(pack.coinsAmount)
        showCoinsSuccessAlert = true
        selectedCoinsPack = nil
    }

    func paymentClosed() {
        selectedCoinsPack = nil
    }

    func buyBoosterTapped(_ item: ShopItem, session: GameSession) {
        guard session.profile.coins >= item.coinsPrice else {
            showNotEnoughCoinsAlert = true
            return
        }
        pendingBuyItem = item
        showConfirmBuyAlert = true
    }

    func cancelConfirmBuy() {
        pendingBuyItem = nil
    }

    func confirmBuy(session: GameSession) {
        guard let item = pendingBuyItem else { return }
        _ = session.spendCoins(item.coinsPrice)
        pendingBuyItem = nil
        showSuccessAlert = true
    }

    var confirmBuyMessage: String {
        guard let item = pendingBuyItem else { return "Are you sure?" }
        return "Buy \"\(item.title)\" for \(item.coinsPrice) coins?"
    }
}
