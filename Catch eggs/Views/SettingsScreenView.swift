//
//  SettingsScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SwiftUI

struct SettingsScreenView: View {

    @Binding var isPresented: Bool
    @EnvironmentObject private var session: GameSession
    @StateObject private var viewModel = SettingsScreenViewModel()

    var body: some View {
        ZStack {
            backgroundImage

            VStack {
                backButton
                Spacer()
                settingsView
                    .padding(.horizontal, 10)
                    .padding(.bottom, 60)
                saveButton
                    .padding(.horizontal, 80)
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            viewModel.load(from: session)
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

    private var settingsView: some View {
        VStack(spacing: 0) {
            Text(viewModel.settingsTitleText)
                .font(.rubikMonoOne(.regular, size: 30))
                .foregroundStyle(.white)

            VStack(spacing: 20) {
                setSound
                setNotifications
                setVibration
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 50)
        }
        .padding(.vertical, 20)
        .background(AnimatedMenuCardBackground())
    }

    private var setSound: some View {
        HStack {
            Text(viewModel.soundText)
                .font(.rubikMonoOne(.regular, size: 20))
                .foregroundStyle(.white)
            Spacer()
            CircleSwitch(isOn: $viewModel.soundEnabled)
        }
    }

    private var setNotifications: some View {
        HStack {
            Text(viewModel.notificationText)
                .font(.rubikMonoOne(.regular, size: 18))
                .foregroundStyle(.white)
            Spacer()
            CircleSwitch(isOn: $viewModel.notificationsEnabled)
        }
    }

    private var setVibration: some View {
        HStack {
            Text(viewModel.vibrationText)
                .font(.rubikMonoOne(.regular, size: 20))
                .foregroundStyle(.white)
            Spacer()
            CircleSwitch(isOn: $viewModel.vibrationEnabled)
        }
    }

    private var saveButton: some View {
        Button {
            viewModel.save(to: session)
            isPresented = false
        } label: {
            Image("saveButtonImage")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    let session = GameSession(
        storage: UserDefaultsPlayerProfileStore(),
        leaderboardStore: UserDefaultsLeaderboardStore()
    )
    SettingsScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
