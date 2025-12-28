//
//  LeaderboardRowView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 26.12.2025.
//
import SwiftUI

struct LeaderboardRowView: View {

    let entry: LeaderboardEntry
    
    let isHighlighted: Bool
    
    @State private var pulse = false

    var body: some View {
        HStack(spacing: 12) {
            userProfileImage
                .frame(height: 70)
            userName
            Spacer()
            score
                .padding(.trailing, 20)
        }
        .padding(.vertical, -4)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.mainManuBorder)
                .padding(.horizontal, 10)
        )
        .onAppear {
            guard isHighlighted else { return }
            pulse = true
        }
    }
    
    
    private var userProfileImage: some View {
        Image("emptyUserImage")
            .resizable()
            .scaledToFit()
            .overlay {
                ZStack {
                    Image(entry.avatarImageName)
                        .resizable()
                        .scaledToFit()
                        .padding(3)
                }
            }
    }
    
//    private var userName: some View {
//        Text(entry.name)
//            .font(.rubikMonoOne(.regular, size: 19))
//            .foregroundStyle(.white)
//            .lineLimit(1)
//            .minimumScaleFactor(0.7)
//    }
//    
//    private var score: some View {
//        Text("\(entry.score.formatted(.number.grouping(.never)))")
//            .font(.rubikMonoOne(.regular, size: 19))
//            .foregroundStyle(.white)
//    }
    private var userName: some View {
            Text(entry.name)
                .font(.rubikMonoOne(.regular, size: 19))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .scaleEffect(isHighlighted ? (pulse ? 1.08 : 0.95) : 1.0)
                .opacity(isHighlighted ? (pulse ? 1.0 : 0.65) : 1.0)
                .animation(
                    isHighlighted ? .easeInOut(duration: 0.75).repeatForever(autoreverses: true) : .default,
                    value: pulse
                )
        }

        private var score: some View {
            Text("\(entry.score.formatted(.number.grouping(.never)))")
                .font(.rubikMonoOne(.regular, size: 19))
                .foregroundStyle(.white)
                .scaleEffect(isHighlighted ? (pulse ? 1.10 : 0.96) : 1.0)
                .opacity(isHighlighted ? (pulse ? 1.0 : 0.65) : 1.0)
                .animation(
                    isHighlighted ? .easeInOut(duration: 0.75).repeatForever(autoreverses: true) : .default,
                    value: pulse
                )
        }
}
