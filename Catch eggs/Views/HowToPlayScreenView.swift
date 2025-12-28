//
//  HowToPlayScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import SwiftUI

struct HowToPlayScreenView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack {
                backButton
                contentView
            }
            
        }
    }
    
    private var backgroundImage: some View {
        Image("menuBackgroundImage")
            .resizable()
            .ignoresSafeArea()
    }
    
    private var backButton: some View {
        HStack {
            Button {
                isPresented = false
            } label: {
                Image("backButtonImage")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            
            Spacer()
        }
        .padding(.leading, 25)
    }
    
    private var contentView: some View {
        ZStack {
            backgroundMenuArea
            VStack {
                titleText
                    .padding(.top, 30)
                Spacer()
            }
        }
        .padding()
    }
    
    private var backgroundMenuArea: some View {
        AnimatedMenuCardBackground()
    }
    
    private var titleText: some View {
        Text("How to play")
            .font(.rubikMonoOne(.regular, size: 30))
            .foregroundStyle(.white)
    }
    
}

#Preview {
    HowToPlayScreenView(isPresented: .constant(true))
}
