//
//  PaymentView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import SwiftUI

struct PaymentView: View {

    let pack: CoinsPack
    let onConfirm: () -> Void
    let onClose: () -> Void

    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: PaymentViewModel.Field?
    @StateObject private var viewModel = PaymentViewModel()

    var body: some View {
        ZStack {
            background
            payCard
        }
        .shadow(radius: 5, x: 5, y: 5)
        .environment(\.colorScheme, .light)
    }

    private var background: some View {
        ZStack {
            Color.mainManuBorder
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
    }

    private var payCard: some View {
        VStack(spacing: 18) {
            titleInfo
            cardInformationInputFields
            confirmButtons
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }

    private var titleInfo: some View {
        VStack {
            Text("Payment")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)

            Text("\(pack.coinsAmount) coins — \(pack.priceText)")
                .font(.headline)
                .foregroundStyle(.black)
        }
    }

    private var cardInformationInputFields: some View {
        VStack(spacing: 12) {
            cardNumberInputField

            HStack(spacing: 12) {
                dateExpireInputField
                cardCVVInputField
            }
        }
        .textFieldStyle(.roundedBorder)
    }

    private var cardNumberInputField: some View {
        fieldContainer(isFocused: focusedField == .cardNumber, field: .cardNumber) {
            TextField("1111 2222 3333 4444", text: $viewModel.cardNumber)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .focused($focusedField, equals: .cardNumber)
                .onChange(of: viewModel.cardNumber) { newValue in
                    viewModel.onCardNumberChanged(newValue)
                }
        }
    }

    private var dateExpireInputField: some View {
        fieldContainer(isFocused: focusedField == .expiry, field: .expiry) {
            TextField("MM / YY", text: $viewModel.expiryDate)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .focused($focusedField, equals: .expiry)
                .onChange(of: viewModel.expiryDate) { newValue in
                    viewModel.onExpiryChanged(newValue)
                }
        }
    }

    private var cardCVVInputField: some View {
        fieldContainer(isFocused: focusedField == .cvv, field: .cvv) {
            SecureField("CVV", text: $viewModel.cvv)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .focused($focusedField, equals: .cvv)
                .onChange(of: viewModel.cvv) { newValue in
                    viewModel.onCVVChanged(newValue)
                }
        }
    }

    private var confirmButtons: some View {
        VStack {
            Button {
                if viewModel.validateFields() {
                    onConfirm()
                    dismiss()
                }
            } label: {
                Text("Pay \(pack.priceText)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Button("Cancel") {
                onClose()
                dismiss()
            }
            .foregroundColor(.red)
            .padding(.vertical, 5)
        }
        .padding(.bottom, 10)
    }

    // MARK: - Privat helpers
    private func fieldContainer<Content: View>(
        isFocused: Bool,
        field: PaymentViewModel.Field,
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor(for: field, isFocused: isFocused), lineWidth: 2)
            )
    }

    private func borderColor(for field: PaymentViewModel.Field, isFocused: Bool) -> Color {
        if viewModel.invalidFields.contains(field) {
            return .red
        }
        return isFocused ? .green : Color.gray.opacity(0.35)
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
