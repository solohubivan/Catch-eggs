//
//  MenuButtonView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 22.12.2025.
//

import SwiftUI

struct MenuButtonView: View {
    let title: String
    let fontSize: CGFloat
    let action: () -> Void

    init(title: String, fontSize: CGFloat = 22, action: @escaping () -> Void) {
        self.title = title
        self.fontSize = fontSize
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Image("menuItemButtonImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)

                Text(title)
                    .font(.rubikMonoOne(.regular, size: fontSize))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.1)
            }
        }
    }
}
