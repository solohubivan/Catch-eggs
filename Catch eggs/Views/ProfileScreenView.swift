//
//  ProfileScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SwiftUI

struct ProfileScreenView: View {
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject private var session: GameSession
    @FocusState private var isNameFocused: Bool
    @State private var isEditingName = false
    @State private var draftName: String = ""
    @State private var showAvatarPicker = false

    var body: some View {
        ZStack {
            backgroundImage
            
            VStack {
                backButton
                contentView
            }
        }
        .onAppear {
            draftName = session.profile.name
        }
        .sheet(isPresented: $showAvatarPicker) {
            AvatarPickerView(
                selectedAvatar: session.profile.avatarImageName,
                onSelect: { avatar in
                    session.setAvatar(avatar)
                    showAvatarPicker = false
                }
            )
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
        VStack {
            profileView
                .padding(.top, 20)
            saveButton
        }
        .padding(.horizontal, 50)
    }
    
    private var profileView: some View {
        ZStack {
            AnimatedMenuCardBackground()

            VStack(spacing: 16) {
                titleArea
                avatarView
            }
            .padding(.vertical, 20)
        }
    }
    
    private var titleArea: some View {
        Group {
            if isEditingName {
                TextField("", text: $draftName)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .submitLabel(.done)
                    .focused($isNameFocused)
                    .onSubmit {
                        isNameFocused = false
                    }
                    .font(.rubikMonoOne(.regular, size: 26))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            } else {
                Text(session.profile.name)
                    .font(.rubikMonoOne(.regular, size: 32))
                    .foregroundStyle(.white)
                    .onTapGesture {
                        startEditingName()
                    }
            }
        }
    }
    
    private var avatarView: some View {
        Image("emptyUserImage")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 40)
            .overlay {
                Image(session.profile.avatarImageName)
                    .resizable()
                    .scaledToFit()
                    .padding(20)
            }
            .onTapGesture {
                showAvatarPicker = true
            }
    }

    
    private var saveButton: some View {
        Button {
            saveName()
            isPresented = false
        } label: {
            Image("saveButtonImage")
                .resizable()
                .scaledToFit()
        }
    }
    
    // MARK: - Private helpers
    private func startEditingName() {
        draftName = session.profile.name
        isEditingName = true
        isNameFocused = true
    }

    private func saveName() {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        session.setName(trimmed)
        isNameFocused = false
        isEditingName = false
    }
}

#Preview {
    let session = GameSession(
        storage: UserDefaultsPlayerProfileStore(),
        leaderboardStore: UserDefaultsLeaderboardStore()
    )
    ProfileScreenView(isPresented: .constant(true))
        .environmentObject(session)
}
