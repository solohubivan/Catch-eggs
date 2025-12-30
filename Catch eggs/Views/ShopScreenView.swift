//
//  ShopScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import SwiftUI

struct ShopScreenView: View {

    @Binding var isPresented: Bool
    @EnvironmentObject private var session: GameSession
    @StateObject private var viewModel = ShopScreenViewModel()

    var body: some View {
        ZStack {
            AnimatedMenuCardBackground()
                .ignoresSafeArea()

            VStack(spacing: 18) {
                headerBar

                ScrollView {
                    coinsPacksRow
                    boostersList
                }

                Spacer(minLength: 10)
            }
        }

        .fullScreenCover(item: $viewModel.selectedCoinsPack) { pack in
            PaymentView(
                pack: pack,
                onConfirm: {
                    viewModel.paymentConfirmed(session: session)
                },
                onClose: {
                    viewModel.paymentClosed()
                }
            )
        }

        .alert("Not enough coins", isPresented: $viewModel.showNotEnoughCoinsAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You don’t have enough coins. Earn more coins in the game or buy gold coins in the shop.")
        }

        .alert("Are you sure?", isPresented: $viewModel.showConfirmBuyAlert) {
            Button("Cancel", role: .cancel) {
                viewModel.cancelConfirmBuy()
            }
            Button("Yes") {
                viewModel.confirmBuy(session: session)
            }
        } message: {
            Text(viewModel.confirmBuyMessage)
        }

        .alert("Success!", isPresented: $viewModel.showSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Purchase successful! Your egg is now in your arsenal!")
        }

        .alert("Success!", isPresented: $viewModel.showCoinsSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Coins have been successfully added to your account. Thank you!")
        }
    }

    private var headerBar: some View {
        HStack {
            backButton
            Spacer()
            GoldCoinsView(amount: session.profile.coins)
                .padding(.trailing, 25)
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

    private var coinsPacksRow: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.coinsPacks) { pack in
                CoinsPackCellView(pack: pack) {
                    viewModel.buyCoinsPackTapped(pack)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    private var boostersList: some View {
        LazyVStack(spacing: 14) {
            ForEach(viewModel.boosters) { item in
                ShopItemCardView(item: item) {
                    viewModel.buyBoosterTapped(item, session: session)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 6)
    }
}

#Preview {
    let session = GameSession(
        storage: UserDefaultsPlayerProfileStore(),
        leaderboardStore: UserDefaultsLeaderboardStore()
    )

    ShopScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
