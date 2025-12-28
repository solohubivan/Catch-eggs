//
//  ShopScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import SwiftUI

struct ShopScreenView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.mainMenuBackground
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                headerBar
                propositions
                Spacer()
            }
        }
    }
    
    
    
    private var headerBar: some View {
        HStack {
            backButton
            Spacer()
            GoldCoinsView(amount: 100)
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
    
    private var propositions: some View {
        VStack {
            Text("Buy coins")
            Text("Buy super eggs")
        }
    }
}

#Preview {
    ShopScreenView(isPresented: .constant(true))
}
