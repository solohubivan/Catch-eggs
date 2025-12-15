//
//  ContentView.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 15.12.2025.
//


import SwiftUI

struct GameScreenView: View {

    @State private var basketOffsetX: CGFloat = 0
    @State private var moveTimer: Timer?

    private let basketSize: CGFloat = 100
    private let moveSpeed: CGFloat = 6
    private let tick: TimeInterval = 0.016


    var body: some View {
        ZStack {
            backgroundImage
            
            gameTools
        }
    }
    
    private var backgroundImage: some View {
        Image("backgroundImageGame")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
    }
    
    private var gameTools: some View {
        GeometryReader { geo in
            
            let minOffsetX = -(geo.size.width / 2) + (basketSize / 2)
            let maxOffsetX =  (geo.size.width / 2) - (basketSize / 2)

            VStack {
                Spacer()
                
                catchingEggsBascet
                
                controlButtons(
                    onLeftPress: {
                        startMoving(direction: -1, minX: minOffsetX, maxX: maxOffsetX)
                    },
                    onRightPress: {
                        startMoving(direction: 1, minX: minOffsetX, maxX: maxOffsetX)
                    }
                )
            }
        }
        .onDisappear {
            stopMoving()
        }
    }
    
    private var catchingEggsBascet: some View {
        Image("basketImage")
            .resizable()
            .frame(width: basketSize, height: basketSize)
            .offset(x: basketOffsetX)
    }
    

    
    

    
    
    
    
    

    // MARK: - Методи ств кнопки і їх функцііонал..
    private func controlButtons(onLeftPress: @escaping () -> Void,
                                onRightPress: @escaping () -> Void) -> some View {
        HStack {
            holdButton(systemName: "arrow.left.circle",
                       onPress: onLeftPress,
                       onRelease: stopMoving)

            Spacer()

            holdButton(systemName: "arrow.right.circle",
                       onPress: onRightPress,
                       onRelease: stopMoving)
        }
        .padding(.horizontal, 50)
        .padding(.bottom, 30)
    }

    private func holdButton(systemName: String,
                            onPress: @escaping () -> Void,
                            onRelease: @escaping () -> Void) -> some View {
        Image(systemName: systemName)
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundStyle(.white)
            .onLongPressGesture(minimumDuration: 0, maximumDistance: 50,
                                pressing: { pressing in
                                    pressing ? onPress() : onRelease()
                                },
                                perform: {})
    }

    private func startMoving(direction: CGFloat, minX: CGFloat, maxX: CGFloat) {
        stopMoving()

        moveTimer = Timer.scheduledTimer(withTimeInterval: tick, repeats: true) { _ in
            basketOffsetX += direction * moveSpeed
            basketOffsetX = min(max(basketOffsetX, minX), maxX)
        }
    }

    private func stopMoving() {
        moveTimer?.invalidate()
        moveTimer = nil
    }
}

#Preview {
    GameScreenView()
}
