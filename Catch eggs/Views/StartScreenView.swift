//
//  StartScreenView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SwiftUI

struct StartScreenView: View {

    @State private var showHomeScreen = false
    @StateObject private var viewModel = StartScreenViewModel()

    var body: some View {
        ZStack {
            screenView
        }
        .onAppear {
            viewModel.startFakeLoading {
                withAnimation(.smooth(duration: 1.0)) {
                    showHomeScreen = true
                }
            }
        }
    }
    
    @ViewBuilder
    private var screenView: some View {
        if showHomeScreen {
            MenuScreenView()
                .transition(.opacity)
        } else {
            contentView
        }
    }

    // MARK: - UI components
    
    private var contentView: some View {
        ZStack {
            backgroundImage

            VStack {
                Spacer()
                progressBar
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
            }
        }
    }
    
    private var backgroundImage: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("menuBackgroundImage")
                .resizable()
                .ignoresSafeArea()

            Image("chikenMainPict")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading)
        }
    }

    private var progressBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [.orange, .yellow],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 3
                )
                .frame(height: 48)

            GeometryReader { geo in
                let width = max(0, geo.size.width * (viewModel.progress / 100))

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)

                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: [.red, .orange, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: width)
                }
            }
            .frame(height: 48)
            .padding(.horizontal, 3)

            shadowProgressText(Int(viewModel.progress))
        }
    }
    
    @ViewBuilder
    private func shadowProgressText(_ value: Int) -> some View {
        let shadowOffsets: [CGSize] = [
            .init(width: -1, height: 0),
            .init(width:  1, height: 0),
            .init(width:  0, height: -1),
            .init(width:  0, height: 1)
        ]
        
        ZStack {
            ForEach(shadowOffsets.indices, id: \.self) { i in
                let o = shadowOffsets[i]
                Text("\(value)%")
                    .font(.rubikMonoOne(.regular, size: 25))
                    .foregroundStyle(.black)
                    .offset(x: o.width, y: o.height)
            }

            Text("\(value)%")
                .font(.rubikMonoOne(.regular, size: 25))
                .foregroundStyle(.white)
        }
    }
}


//#Preview {
//    StartScreenView()
//}
