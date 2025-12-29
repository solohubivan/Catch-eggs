//
//  GameScene.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SpriteKit

final class GameScene: SKScene {
    
    var onCatch: ((EggKind) -> Void)?
    var onMiss: (() -> Void)?
    var onTimeOver: (() -> Void)?
    
    private let basket = SKSpriteNode(imageNamed: "basketImage")
    private let basketSize: CGFloat = 100
    private var moveDirection: CGFloat = 0
    private let basketMoveSpeed: CGFloat = 360
    
    private let eggSize = CGSize(width: 40, height: 50)
    private let dynamiteSize = CGSize(width: 70, height: 70)
    private let sunSize = CGSize(width: 60, height: 60)
    
    private let eggTextures: [SKTexture] = (1...7).map {
        SKTexture(imageNamed: "planeEgg\($0)")
    }
    private let magicEggTextures: [SKTexture] = (1...5).map {
        SKTexture(imageNamed: "magicEgg\($0)")
    }
    private let dynamiteTexture = SKTexture(imageNamed: "nuclearBomb")
    private let sunTexture = SKTexture(imageNamed: "sun")

    private var lastUpdate: TimeInterval = 0

    override func didMove(to view: SKView) {
        setupBackground()
        setupBascet()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let dt = makeDeltaTime(currentTime) else { return }
        updateBasketPosition(dt: dt)
        updateEggs()
    }
    
    // MARK: - Public API
    func setMoveDirection(_ direction: CGFloat) {
        moveDirection = direction
    }
    
    func resetTimingAfterPause() {
        lastUpdate = 0
    }
    
    func createLevel(_ levelNumber: Int) {
        resetGame()

        guard let level = GameLevel.level(for: levelNumber) else { return }
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
                let kind = kindFromNode(node) ?? .plain
                onCatch?(kind)
                animateCatchAndRemove(egg: node)
                continue
            }

            if node.position.y < -100 {
                node.removeFromParent()

                let kind = kindFromNode(node) ?? .plain
                if kind.countsAsMiss {
                    onMiss?()
                }
            }
        }
    }
    
    private func kindFromNode(_ node: SKNode) -> EggKind? {
        (node as? SKSpriteNode)?.userData?["eggKind"] as? EggKind
    }

    private func clampX(_ x: CGFloat, halfWidth: CGFloat) -> CGFloat {
        min(max(x, halfWidth), size.width - halfWidth)
    }
        
    private func basketMinX() -> CGFloat { basketSize / 2 }
    private func basketMaxX() -> CGFloat { size.width - basketSize / 2 }
    
    // MARK: - Spawning
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
    
    private func spawnEgg(speed: CGFloat, trajectory: EggTrajectory, kind: EggKind) {
        let egg = makeEggNode(kind: kind)
        addEggToScene(egg, kind: kind)
        runEggMovement(egg, speed: speed, trajectory: trajectory)
        runEggRotation(egg, speed: speed)
    }

    // MARK: - Egg building
    private func makeEggNode(kind: EggKind) -> SKSpriteNode {
        let node = SKSpriteNode(texture: texture(for: kind))
        node.name = "egg"
        node.size = size(for: kind)
        node.userData = ["eggKind": kind]
        return node
    }
    
    private func texture(for kind: EggKind) -> SKTexture {
        switch kind {
        case .plain:
            return eggTextures.randomElement()!
        case .magic:
            return magicEggTextures.randomElement()!
        case .dynamite:
            return dynamiteTexture
        case .sun:
            return sunTexture
        }
    }
    
    private func addEggToScene(_ egg: SKSpriteNode, kind: EggKind) {
        egg.position = makeEggStartPosition(for: kind)
        addChild(egg)
    }
    
    private func makeEggStartPosition(for kind: EggKind) -> CGPoint {
        let itemSize = size(for: kind)
        let halfW = itemSize.width / 2

        let startX = CGFloat.random(in: halfW...(size.width - halfW))
        let startY = size.height + itemSize.height
        return CGPoint(x: startX, y: startY)
    }

    // MARK: - Egg actions
    private func runEggMovement(_ node: SKSpriteNode, speed: CGFloat, trajectory: EggTrajectory) {
        let endY: CGFloat = -120
        let duration = makeFallDuration(fromY: node.position.y, toY: endY, speed: speed)
        let halfWidth = node.size.width / 2

        let move = makeMovementAction(
            from: node.position,
            toY: endY,
            duration: duration,
            trajectory: trajectory,
            halfWidth: halfWidth
        )

        node.run(move)
    }

    private func makeFallDuration(fromY: CGFloat, toY: CGFloat, speed: CGFloat) -> TimeInterval {
        TimeInterval((fromY - toY) / speed)
    }
    
    private func makeMovementAction( from start: CGPoint, toY endY: CGFloat, duration: TimeInterval, trajectory: EggTrajectory, halfWidth: CGFloat) -> SKAction {
        switch trajectory {
        case .straight:
            return straightMove(from: start, toY: endY, duration: duration)

        case .diagonal:
            return diagonalMove(from: start, toY: endY, duration: duration, halfWidth: halfWidth)

        case .parabola:
            return parabolaMove(from: start, toY: endY, duration: duration, halfWidth: halfWidth)
        }
    }

    private func straightMove(from start: CGPoint, toY endY: CGFloat, duration: TimeInterval) -> SKAction {
        SKAction.move(to: CGPoint(x: start.x, y: endY), duration: duration)
    }
    
    private func diagonalMove(
        from start: CGPoint,
        toY endY: CGFloat,
        duration: TimeInterval,
        halfWidth: CGFloat
    ) -> SKAction {
        let offsetX = CGFloat.random(in: -120...120)
        let endX = clampX(start.x + offsetX, halfWidth: halfWidth)
        return SKAction.move(to: CGPoint(x: endX, y: endY), duration: duration)
    }

    private func parabolaMove(
        from start: CGPoint,
        toY endY: CGFloat,
        duration: TimeInterval,
        halfWidth: CGFloat
    ) -> SKAction {
        let rawControlX = start.x + CGFloat.random(in: -150...150)
        let rawEndX = start.x + CGFloat.random(in: -100...100)

        let controlX = clampX(rawControlX, halfWidth: halfWidth)
        let endX = clampX(rawEndX, halfWidth: halfWidth)
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
    
    private func size(for kind: EggKind) -> CGSize {
        switch kind {
        case .plain, .magic:
            return eggSize
        case .dynamite:
            return dynamiteSize
        case .sun:
            return sunSize
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
