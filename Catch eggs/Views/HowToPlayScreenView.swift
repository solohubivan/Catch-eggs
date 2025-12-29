//
//  HowToPlayScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 28.12.2025.
//

import SwiftUI

struct HowToPlayScreenView: View {
    
    @Binding var isPresented: Bool
    @StateObject private var viewModel = HowToPlayScreenViewModel()
    
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
            AnimatedMenuCardBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    Spacer()
                    titleText
                        .padding(.top, 15)
                    rules
                }
                .padding(.bottom, 20)
            }
        }
        .padding()
    }
    
    private var titleText: some View {
        Text(viewModel.titleText)
            .font(.rubikMonoOne(.regular, size: 30))
            .foregroundStyle(.white)
    }
    
    private var rules: some View {
        VStack(spacing: 10) {
            mainRuleText
            fallItemsRules
            scoringRules
            gameOverRule
            bestWishes
        }
        .padding(.top, 15)
    }
    
    private var mainRuleText: some View {
        Text(viewModel.mainRuleText)
            .font(.system(size: 21, weight: .semibold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
    
    private var fallItemsRules: some View {
        Text("""
        🥚 \(viewModel.catchEggsRuleText)
        ✨ \(viewModel.catchMagicEggsRuleText)
        ☀️ \(viewModel.catchSunRuleText)
        💣 \(viewModel.catchBombsRuleText)
        """)
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.white)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 5)
        
    }
    
    private var scoringRules: some View {
        VStack(spacing: 8) {
            Text("\(viewModel.scoringTitleText):")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("• \(viewModel.scoringNormalEgg): +1")
                Text("• \(viewModel.scoringMagicEgg): +5")
                Text("• \(viewModel.scoringSun): +10")
                Text("• \(viewModel.scoringBombCaught): −20")
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
        }
        .padding(.top, 10)
    }
    
    private var gameOverRule: some View {
        VStack(spacing: 6) {
            Text("\(viewModel.gameOverTitleText):")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Text(viewModel.gameOverRuleText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
        }
        .padding(.top, 10)
    }
    
    private var bestWishes: some View {
        VStack(spacing: 6) {
            Text(viewModel.showYourSkilsText)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .multilineTextAlignment(.center)
            
            Text(viewModel.goodLuckText)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 25)
        .padding(.horizontal, 10)
    }
}

#Preview {
    HowToPlayScreenView(isPresented: .constant(true))
}
