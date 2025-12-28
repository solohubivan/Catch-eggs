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

    @State private var soundEnabled = true
    @State private var notificationsEnabled = true
    @State private var vibrationEnabled = true
    
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
        .onAppear(perform: loadSettingsFromProfile)
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
            settingsViewTitleText
            
            VStack(spacing: 20) {
                setSound
                setNotifications
                setVibration
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 50)
        }
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.mainMenuBackground.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.mainManuBorder, lineWidth: 2)
                )
        )
        
    }
    
    private var settingsViewTitleText: some View {
        Text("SETTINGS")
            .font(.rubikMonoOne(.regular, size: 30))
            .foregroundStyle(.white)
            
    }
    
    private var setSound: some View {
        HStack {
            Text("SOUND")
                .font(.rubikMonoOne(.regular, size: 20))
                .foregroundStyle(.white)
            
            Spacer()
            
            CircleSwitch(isOn: $soundEnabled)
        }
    }
    
    private var setNotifications: some View {
        HStack {
            Text("NOTIFICATION")
                .font(.rubikMonoOne(.regular, size: 18))
                .foregroundStyle(.white)
            
            Spacer()
            
            CircleSwitch(isOn: $notificationsEnabled)
        }
    }
    
    private var setVibration: some View {
        HStack {
            Text("VIBRATION")
                .font(.rubikMonoOne(.regular, size: 20))
                .foregroundStyle(.white)
            
            Spacer()
            
            CircleSwitch(isOn: $vibrationEnabled)
        }
    }
    
    private var saveButton: some View {
        Button {
            saveSettingsToProfile()
            isPresented = false
        } label: {
            Image("saveButtonImage")
                .resizable()
                .scaledToFit()
        }
    }
    
    
    private func loadSettingsFromProfile() {
            let s = session.profile.settings
            soundEnabled = s.soundEnabled
            notificationsEnabled = s.notificationsEnabled
            vibrationEnabled = s.vibrationEnabled
        }
    
    private func saveSettingsToProfile() {
            let newSettings = GameSettings(
                soundEnabled: soundEnabled,
                notificationsEnabled: notificationsEnabled,
                vibrationEnabled: vibrationEnabled
            )
            session.setSettings(newSettings)
        }

}

//#Preview {
//    SettingsScreenView(isPresented: .constant(true))
//}
