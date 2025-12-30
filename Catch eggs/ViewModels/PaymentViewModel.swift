//
//  PaymentViewModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 30.12.2025.
//

import SwiftUI
import Combine

@MainActor
final class PaymentViewModel: ObservableObject {

    enum Field: Hashable {
        case cardNumber, expiry, cvv
    }

    @Published var cardNumber: String = ""
    @Published var expiryDate: String = ""
    @Published var cvv: String = ""
    @Published var invalidFields: Set<Field> = []

    func onCardNumberChanged(_ newValue: String) {
        cardNumber = formatCardNumber(newValue)
        invalidFields.remove(.cardNumber)
    }

    func onExpiryChanged(_ newValue: String) {
        expiryDate = formatExpiry(newValue)
        invalidFields.remove(.expiry)
    }

    func onCVVChanged(_ newValue: String) {
        cvv = formatCVV(newValue)
        invalidFields.remove(.cvv)
    }
    
    func validateFields() -> Bool {
        invalidFields.removeAll()

        let cardDigits = digitsOnly(cardNumber)
        if cardDigits.count != 16 {
            invalidFields.insert(.cardNumber)
        }
        
        let expiryDigits = digitsOnly(expiryDate)
        if expiryDigits.count != 4 {
            invalidFields.insert(.expiry)
        } else {
            let month = Int(expiryDigits.prefix(2)) ?? 0
            let year = Int(expiryDigits.suffix(2)) ?? 0

            if !(1...12).contains(month) || !(25...30).contains(year) {
                invalidFields.insert(.expiry)
            }
        }
        
        if digitsOnly(cvv).count != 3 {
            invalidFields.insert(.cvv)
        }

        return invalidFields.isEmpty
    }

    // MARK: - Privat helpers
    private func digitsOnly(_ text: String) -> String {
        text.filter(\.isNumber)
    }

    private func formatCardNumber(_ input: String) -> String {
        let digits = String(digitsOnly(input).prefix(16))
        var result = ""
        for (index, ch) in digits.enumerated() {
            if index != 0 && index % 4 == 0 { result.append(" ") }
            result.append(ch)
        }
        return result
    }

    private func formatExpiry(_ input: String) -> String {
        let digits = String(digitsOnly(input).prefix(4))
        var result = ""
        for (index, ch) in digits.enumerated() {
            if index == 2 { result.append(" / ") }
            result.append(ch)
        }
        return result
    }

    private func formatCVV(_ input: String) -> String {
        String(digitsOnly(input).prefix(3))
    }
}
