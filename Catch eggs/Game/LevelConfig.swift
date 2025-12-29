//
//  LevelConfig.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 23.12.2025.
//

import CoreGraphics

struct LevelConfig {
    let id: Int
    let waves: [EggWaveConfigModel]
}

enum GameLevel {
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    case level8
    case level9
    
    var config: LevelConfig {
        switch self {
        case .level1:
            return LevelConfig(
                id: 1,
                waves: [
                    EggWaveConfigModel(
                        id: "l1wave1",
                        eggsCount: 30,
                        interval: 2.5,
                        startDelay: 0,
                        speedRange: 140...180,
                        trajectories: [.straight],
                        allowedEggKinds: [.plain, .magic]
                    ),
                    EggWaveConfigModel(
                        id: "l1wave2",
                        eggsCount: 30,
                        interval: 7,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.sun]
                    ),
                    EggWaveConfigModel(
                        id: "l1wavebonus",
                        eggsCount: 20,
                        interval: 4,
                        startDelay: 30,
                        speedRange: 80...90,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.dynamite, .sun]
                    ),
                    EggWaveConfigModel(
                        id: "l1wavebonus",
                        eggsCount: 20,
                        interval: 4,
                        startDelay: 0,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.dynamite, .magic, .sun, .plain]
                    )
                ]
            )

        case .level2:
            return LevelConfig(
                id: 2,
                waves: [
                    EggWaveConfigModel(
                        id: "l2wave1",
                        eggsCount: 30,
                        interval: 3,
                        startDelay: 0,
                        speedRange: 140...180,
                        trajectories: [.straight, .parabola ],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l2wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 10,
                        speedRange: 70...80,
                        trajectories: [.parabola, .straight],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l2wave3",
                        eggsCount: 15,
                        interval: 8,
                        startDelay: 4,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.sun, .dynamite]
                    )
                ]
            )

        case .level3:
            return LevelConfig(
                id: 3,
                waves: [
                    EggWaveConfigModel(
                        id: "l3wave1",
                        eggsCount: 35,
                        interval: 2.3,
                        startDelay: 0,
                        speedRange: 160...190,
                        trajectories: [.straight, .parabola],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l3wave2",
                        eggsCount: 18,
                        interval: 5.5,
                        startDelay: 6,
                        speedRange: 85...105,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l3wave3",
                        eggsCount: 14,
                        interval: 7,
                        startDelay: 10,
                        speedRange: 90...110,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun]
                    ),
                    EggWaveConfigModel(
                        id: "l3wave4",
                        eggsCount: 12,
                        interval: 8,
                        startDelay: 18,
                        speedRange: 95...115,
                        trajectories: [.diagonal, .parabola],
                        allowedEggKinds: [.dynamite, .sun]
                    )
                ]
            )

        case .level4:
            return LevelConfig(
                id: 4,
                waves: [
                    EggWaveConfigModel(
                        id: "l4wave1",
                        eggsCount: 40,
                        interval: 2.0,
                        startDelay: 0,
                        speedRange: 175...205,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l4wave2",
                        eggsCount: 22,
                        interval: 5.0,
                        startDelay: 6,
                        speedRange: 95...120,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l4wave3",
                        eggsCount: 16,
                        interval: 6.5,
                        startDelay: 12,
                        speedRange: 95...120,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun, .plain]
                    ),
                    EggWaveConfigModel(
                        id: "l4wave4",
                        eggsCount: 16,
                        interval: 7.0,
                        startDelay: 20,
                        speedRange: 100...125,
                        trajectories: [.diagonal, .parabola],
                        allowedEggKinds: [.dynamite, .plain]
                    )
                ]
            )

        case .level5:
            return LevelConfig(
                id: 5,
                waves: [
                    EggWaveConfigModel(
                        id: "l5wave1",
                        eggsCount: 45,
                        interval: 1.8,
                        startDelay: 0,
                        speedRange: 185...220,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l5wave2",
                        eggsCount: 18,
                        interval: 4.8,
                        startDelay: 5,
                        speedRange: 105...130,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l5wave3",
                        eggsCount: 18,
                        interval: 6.0,
                        startDelay: 10,
                        speedRange: 105...130,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun]
                    ),
                    EggWaveConfigModel(
                        id: "l5wave4",
                        eggsCount: 20,
                        interval: 6.0,
                        startDelay: 16,
                        speedRange: 110...135,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.dynamite, .sun]
                    ),
                    EggWaveConfigModel(
                        id: "l5wave5_bonus",
                        eggsCount: 16,
                        interval: 5.0,
                        startDelay: 26,
                        speedRange: 115...140,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain, .magic, .sun]
                    )
                ]
            )

        case .level6:
            return LevelConfig(
                id: 6,
                waves: [
                    EggWaveConfigModel(
                        id: "l6wave1",
                        eggsCount: 50,
                        interval: 1.65,
                        startDelay: 0,
                        speedRange: 200...235,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l6wave2",
                        eggsCount: 22,
                        interval: 4.5,
                        startDelay: 5,
                        speedRange: 120...145,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l6wave3",
                        eggsCount: 18,
                        interval: 5.5,
                        startDelay: 10,
                        speedRange: 120...150,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun, .plain]
                    ),
                    EggWaveConfigModel(
                        id: "l6wave4",
                        eggsCount: 24,
                        interval: 5.5,
                        startDelay: 15,
                        speedRange: 125...155,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.dynamite, .plain, .sun]
                    ),
                    EggWaveConfigModel(
                        id: "l6wave5",
                        eggsCount: 18,
                        interval: 4.8,
                        startDelay: 25,
                        speedRange: 130...160,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.magic, .plain]
                    )
                ]
            )

        case .level7:
            return LevelConfig(
                id: 7,
                waves: [
                    EggWaveConfigModel(
                        id: "l7wave1",
                        eggsCount: 55,
                        interval: 1.5,
                        startDelay: 0,
                        speedRange: 215...255,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l7wave2",
                        eggsCount: 26,
                        interval: 4.2,
                        startDelay: 5,
                        speedRange: 130...160,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l7wave3",
                        eggsCount: 22,
                        interval: 5.0,
                        startDelay: 10,
                        speedRange: 130...165,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.dynamite, .sun]
                    ),
                    EggWaveConfigModel(
                        id: "l7wave4_bonus",
                        eggsCount: 18,
                        interval: 4.0,
                        startDelay: 18,
                        speedRange: 135...170,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun, .magic]
                    ),
                    EggWaveConfigModel(
                        id: "l7wave5",
                        eggsCount: 22,
                        interval: 4.5,
                        startDelay: 26,
                        speedRange: 140...175,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.dynamite, .plain, .magic]
                    )
                ]
            )

        case .level8:
            return LevelConfig(
                id: 8,
                waves: [
                    EggWaveConfigModel(
                        id: "l8wave1",
                        eggsCount: 60,
                        interval: 1.35,
                        startDelay: 0,
                        speedRange: 235...275,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l8wave2",
                        eggsCount: 28,
                        interval: 3.8,
                        startDelay: 5,
                        speedRange: 145...180,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l8wave3",
                        eggsCount: 24,
                        interval: 4.6,
                        startDelay: 10,
                        speedRange: 145...185,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun, .plain]
                    ),
                    EggWaveConfigModel(
                        id: "l8wave4",
                        eggsCount: 28,
                        interval: 4.6,
                        startDelay: 14,
                        speedRange: 150...190,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.dynamite, .sun]
                    ),
                    EggWaveConfigModel(
                        id: "l8wave5_final",
                        eggsCount: 26,
                        interval: 4.0,
                        startDelay: 24,
                        speedRange: 155...200,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain, .magic, .dynamite]
                    )
                ]
            )

        case .level9:
            return LevelConfig(
                id: 9,
                waves: [
                    EggWaveConfigModel(
                        id: "l9wave1",
                        eggsCount: 65,
                        interval: 1.25,
                        startDelay: 0,
                        speedRange: 255...300,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave2",
                        eggsCount: 30,
                        interval: 3.6,
                        startDelay: 5,
                        speedRange: 165...205,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave3",
                        eggsCount: 26,
                        interval: 4.2,
                        startDelay: 9,
                        speedRange: 165...210,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave4",
                        eggsCount: 34,
                        interval: 4.2,
                        startDelay: 12,
                        speedRange: 170...215,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.dynamite, .plain]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave5_bonus",
                        eggsCount: 24,
                        interval: 3.4,
                        startDelay: 22,
                        speedRange: 175...225,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.sun, .magic]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave6_final",
                        eggsCount: 30,
                        interval: 3.6,
                        startDelay: 30,
                        speedRange: 185...235,
                        trajectories: [.straight, .parabola, .diagonal],
                        allowedEggKinds: [.plain, .magic, .sun, .dynamite]
                    )
                ]
            )
        }
    }

    static func level(for number: Int) -> GameLevel? {
        switch number {
        case 1: return .level1
        case 2: return .level2
        case 3: return .level3
        case 4: return .level4
        case 5: return .level5
        case 6: return .level6
        case 7: return .level7
        case 8: return .level8
        case 9: return .level9
        default: return nil
        }
    }
}
