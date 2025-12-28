//
//  GameScene.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SpriteKit

enum EggTrajectory {
    case straight
    case diagonal
    case parabola
}

struct EggWaveConfigModel {
    let id: String
    let eggsCount: Int
    let interval: TimeInterval
    let startDelay: TimeInterval
    let speedRange: ClosedRange<CGFloat>
    let trajectories: [EggTrajectory]
    let allowedEggKinds: [EggKind]
}

enum EggKind {
    case plain
    case magic
}


final class GameScene: SKScene {
    
    private let basket = SKSpriteNode(imageNamed: "basketImage")
    private let basketSize: CGFloat = 100
    private var moveDirection: CGFloat = 0
    private let basketMoveSpeed: CGFloat = 360
    
    private let eggSize = CGSize(width: 40, height: 50)
    private let eggTextures: [SKTexture] = (1...7).map {
        SKTexture(imageNamed: "planeEgg\($0)")
    }
    private let magicEggTextures: [SKTexture] = (1...5).map {
        SKTexture(imageNamed: "magicEgg\($0)")
    }

    private var lastUpdate: TimeInterval = 0
    
    var onScore: (() -> Void)?
    var onMiss: (() -> Void)?
    var onTimeOver: (() -> Void)?
    
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupBascet()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let dt = makeDeltaTime(currentTime) else { return }
        updateBasketPosition(dt: dt)
        updateEggs()
    }
    
    // MARK: -
    func setMoveDirection(_ direction: CGFloat) {
        moveDirection = direction
    }
    
    func resetTimingAfterPause() {
        lastUpdate = 0
    }
    
    func createLevel(_ levelNumber: Int) {
        resetGame()

        guard let level = GameLevel.from(levelNumber) else { return }
        level.config.waves.forEach { startEggsWave($0) }
    }
    
    func resetGame() {
        children.filter { $0.name == "egg" || $0.name == "caughtEgg" }
            .forEach { $0.removeFromParent() }
        removeAllActions()
        lastUpdate = 0
    }

    // MARK: - Update helpers
    private func makeDeltaTime(_ currentTime: TimeInterval) -> TimeInterval? {
        let deltaTime = (lastUpdate == 0) ? 0 : currentTime - lastUpdate
        lastUpdate = currentTime
        return deltaTime > 0 ? deltaTime : nil
    }

    private func updateBasketPosition(dt: TimeInterval) {
        guard moveDirection != 0 else { return }
        basket.position.x += moveDirection * basketMoveSpeed * dt
        basket.position.x = min(max(basket.position.x, basketMinX()), basketMaxX())
    }

    private func updateEggs() {
        for node in children {
            guard node.name == "egg" else { continue }
            node.zPosition = 10

            if checkCatch(egg: node) {
                onScore?()
                animateCatchAndRemove(egg: node)
                continue
            }

            if node.position.y < -100 {
                node.removeFromParent()
                onMiss?()
            }
        }
    }
    
    private func clampX(_ x: CGFloat) -> CGFloat {
        min(max(x, eggSize.width), size.width - eggSize.width)
    }
    
    private func basketMinX() -> CGFloat { basketSize / 2 }
    private func basketMaxX() -> CGFloat { size.width - basketSize / 2 }
    
    // MARK: -
    private func startEggsWave(_ config: EggWaveConfigModel) {
        removeAction(forKey: config.id)

        let start = SKAction.wait(forDuration: config.startDelay)
        let spawnOne = SKAction.run { [weak self] in
            guard let self else { return }

            let speed = CGFloat.random(in: config.speedRange)
            let trajectory = config.trajectories.randomElement() ?? .straight
            let kind = config.allowedEggKinds.randomElement() ?? .plain

            self.spawnEgg(speed: speed, trajectory: trajectory, kind: kind)
        }
        
        let step = SKAction.sequence([
            spawnOne,
            SKAction.wait(forDuration: config.interval)
        ])
        
        let waveBody = SKAction.repeat(step, count: config.eggsCount)
        let wave = SKAction.sequence([start, waveBody])
        run(wave, withKey: config.id)
    }
    
    private func spawnEgg(
        speed: CGFloat,
        trajectory: EggTrajectory,
        kind: EggKind
    ) {
        let egg = makeEggNode(kind: kind)
        addEggToScene(egg)
        runEggMovement(egg, speed: speed, trajectory: trajectory)
        runEggRotation(egg, speed: speed)
    }

    // MARK: - Egg building
    private func makeEggNode(kind: EggKind) -> SKSpriteNode {
        let texture = texture(for: kind)
        let egg = SKSpriteNode(texture: texture)
        egg.name = "egg"
        egg.size = eggSize
        egg.userData = ["eggKind": kind.userDataValue]
        return egg
    }

    private func texture(for kind: EggKind) -> SKTexture {
        switch kind {
        case .plain:
            return eggTextures.randomElement()!
        case .magic:
            return magicEggTextures.randomElement()!
        }
    }

    private func addEggToScene(_ egg: SKSpriteNode) {
        egg.position = makeEggStartPosition()
        addChild(egg)
    }

    private func makeEggStartPosition() -> CGPoint {
        let startX = CGFloat.random(in: 40...(size.width - 40))
        let startY = size.height + 60
        return CGPoint(x: startX, y: startY)
    }

    // MARK: - Egg actions
    private func runEggMovement(
        _ egg: SKSpriteNode,
        speed: CGFloat,
        trajectory: EggTrajectory
    ) {
        let endY: CGFloat = -120
        let duration = makeFallDuration(fromY: egg.position.y, toY: endY, speed: speed)
        let move = makeMovementAction(
            from: egg.position,
            toY: endY,
            duration: duration,
            trajectory: trajectory
        )
        egg.run(move)
    }

    private func makeFallDuration(fromY: CGFloat, toY: CGFloat, speed: CGFloat) -> TimeInterval {
        TimeInterval((fromY - toY) / speed)
    }

    private func makeMovementAction(
        from start: CGPoint,
        toY endY: CGFloat,
        duration: TimeInterval,
        trajectory: EggTrajectory
    ) -> SKAction {
        switch trajectory {
        case .straight:
            return straightMove(from: start, toY: endY, duration: duration)

        case .diagonal:
            return diagonalMove(from: start, toY: endY, duration: duration)

        case .parabola:
            return parabolaMove(from: start, toY: endY, duration: duration)
        }
    }

    private func straightMove(from start: CGPoint, toY endY: CGFloat, duration: TimeInterval) -> SKAction {
        SKAction.move(to: CGPoint(x: start.x, y: endY), duration: duration)
    }

    private func diagonalMove(from start: CGPoint, toY endY: CGFloat, duration: TimeInterval) -> SKAction {
        let offsetX = CGFloat.random(in: -120...120)
        let endX = clampX(start.x + offsetX)
        return SKAction.move(to: CGPoint(x: endX, y: endY), duration: duration)
    }

    private func parabolaMove(from start: CGPoint, toY endY: CGFloat, duration: TimeInterval) -> SKAction {
        let rawControlX = start.x + CGFloat.random(in: -150...150)
        let rawEndX = start.x + CGFloat.random(in: -100...100)

        let controlX = clampX(rawControlX)
        let endX = clampX(rawEndX)
        let controlY = size.height * 0.6

        let path = CGMutablePath()
        path.move(to: start)
        path.addQuadCurve(
            to: CGPoint(x: endX, y: endY),
            control: CGPoint(x: controlX, y: controlY)
        )

        return SKAction.follow(path, asOffset: false, orientToPath: false, duration: duration)
    }

    private func runEggRotation(_ egg: SKSpriteNode, speed: CGFloat) {
        let rotateForever = makeRotationAction(speed: speed)
        egg.run(rotateForever)
    }

    private func makeRotationAction(speed: CGFloat) -> SKAction {
        let rotationDuration = max(0.35, 1000 / speed)
        let direction: CGFloat = Bool.random() ? 1 : -1

        let rotateOnce = SKAction.rotate(byAngle: direction * .pi * 2, duration: rotationDuration)
        return .repeatForever(rotateOnce)
    }

    private func checkCatch(egg: SKNode) -> Bool {
        let eggFrame = egg.frame
        let basketFrame = basket.frame

        let isInsideHorizontally =
            eggFrame.minX >= basketFrame.minX &&
            eggFrame.maxX <= basketFrame.maxX

        let isAtBasketHeight =
            eggFrame.minY <= basketFrame.midY &&
            eggFrame.maxY >= basketFrame.minY

        return isInsideHorizontally && isAtBasketHeight
    }
    
    private func animateCatchAndRemove(egg: SKNode) {
        egg.name = "caughtEgg"
        egg.removeAllActions()
        let target = CGPoint(x: basket.position.x, y: basket.position.y - 5)
        let move = SKAction.move(to: target, duration: 0.12)
        move.timingMode = .easeIn
        let scale = SKAction.scale(to: 0.15, duration: 0.12)
        scale.timingMode = .easeIn
        let fade = SKAction.fadeOut(withDuration: 0.12)
        let group = SKAction.group([move, scale, fade])
        
        egg.run(group) { [weak egg] in
            egg?.removeFromParent()
        }
    }
    
    // MARK: - Setup UI
    private func setupBackground() {
        let bg = SKSpriteNode(imageNamed: "backgroundImageGame")
        bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        bg.size = size
        bg.zPosition = -10
        addChild(bg)
    }

    private func setupBascet() {
        basket.size = CGSize(width: basketSize, height: basketSize)
        basket.position = CGPoint(x: size.width / 2, y: 220)
        addChild(basket)
    }
    
}

private extension EggKind {
    var userDataValue: String {
        switch self {
        case .plain: return "plain"
        case .magic: return "magic"
        }
    }
}

//    private func spawnEgg(
//        speed: CGFloat,
//        trajectory: EggTrajectory,
//        kind: EggKind
//    ) {
//        let texture: SKTexture
//
//        switch kind {
//        case .plain:
//            texture = eggTextures.randomElement()!
//        case .magic:
//            texture = magicEggTextures.randomElement()!
//        }
//
//        let egg = SKSpriteNode(texture: texture)
//        egg.name = "egg"
//        egg.size = eggSize
//        egg.userData = ["eggKind": (kind == .magic ? "magic" : "plain")]
//
//
//
//        let startX = CGFloat.random(in: 40...(size.width - 40))
//        let startY = size.height + 60
//        egg.position = CGPoint(x: startX, y: startY)
//        addChild(egg)
//
//        let endY: CGFloat = -120
//        let duration = (startY - endY) / speed
//
//        let action: SKAction
//
//        switch trajectory {
//        case .straight:
//            let endPoint = CGPoint(x: startX, y: endY)
//            action = SKAction.move(to: endPoint, duration: duration)
//
//        case .diagonal:
//            let offsetX = CGFloat.random(in: -120...120)
//            let endX = clampX(startX + offsetX)
//            action = SKAction.move(to: CGPoint(x: endX, y: endY), duration: duration)
//
//        case .parabola:
//            let rawControlX = startX + CGFloat.random(in: -150...150)
//            let rawEndX = startX + CGFloat.random(in: -100...100)
//
//            let controlX = clampX(rawControlX)
//            let endX = clampX(rawEndX)
//            let controlY = size.height * 0.6
//
//            let path = CGMutablePath()
//            path.move(to: egg.position)
//            path.addQuadCurve(
//                to: CGPoint(x: endX, y: endY),
//                control: CGPoint(x: controlX, y: controlY)
//            )
//
//            action = SKAction.follow(
//                path,
//                asOffset: false,
//                orientToPath: false,
//                duration: duration
//            )
//        }
//
//        // 🔄 обертання залежить від швидкості
//        let rotationDuration = max(0.35, 1000 / speed)
//        let rotationDirection: CGFloat = Bool.random() ? 1 : -1
//
//        let rotate = SKAction.rotate(
//            byAngle: rotationDirection * .pi * 2,
//            duration: rotationDuration
//        )
//
//        egg.run(action)
//        egg.run(.repeatForever(rotate))
//    }
