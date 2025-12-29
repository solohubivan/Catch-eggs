//
//  GoldCoinsView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import SwiftUI

struct GoldCoinsView: View {

    let amount: Int

    var body: some View {
        HStack(spacing: -20) {
            Text("\(amount.formatted(.number.grouping(.never)))")
                .font(.rubikMonoOne(.regular, size: 15))
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.orange)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.red, lineWidth: 1)
                )

            Image("goldCoinImage")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}
