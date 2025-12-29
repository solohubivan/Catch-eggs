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
//                    EggWaveConfigModel(
//                        id: "l1wave1",
//                        eggsCount: 30,
//                        interval: 2.5,
//                        startDelay: 0,
//                        speedRange: 140...180,
//                        trajectories: [.straight],
//                        allowedEggKinds: [.plain]
//                    ),
//                    EggWaveConfigModel(
//                        id: "l1wave2",
//                        eggsCount: 5,
//                        interval: 7,
//                        startDelay: 10,
//                        speedRange: 80...100,
//                        trajectories: [.parabola, .diagonal, .straight],
//                        allowedEggKinds: [.magic]
//                    )
                    EggWaveConfigModel(
                        id: "l1waveTest",
                        eggsCount: 20,
                        interval: 4,
                        startDelay: 0,
                        speedRange: 160...190,
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
                        interval: 2,
                        startDelay: 0,
                        speedRange: 140...180,
                        trajectories: [.straight, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l2wave2",
                        eggsCount: 15,
                        interval: 6,
                        startDelay: 10,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )

        case .level3:
            return LevelConfig(
                id: 3,
                waves: [
                    EggWaveConfigModel(
                        id: "l3wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l3wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
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
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l4wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )
            
        case .level5:
            return LevelConfig(
                id: 5,
                waves: [
                    EggWaveConfigModel(
                        id: "l5wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l5wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )
            
        case .level6:
            return LevelConfig(
                id: 6,
                waves: [
                    EggWaveConfigModel(
                        id: "l6wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l6wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )
            
        case .level7:
            return LevelConfig(
                id: 7,
                waves: [
                    EggWaveConfigModel(
                        id: "l7wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l7wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )
            
        case .level8:
            return LevelConfig(
                id: 8,
                waves: [
                    EggWaveConfigModel(
                        id: "l8wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l8wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
                    )
                ]
            )
            
        case .level9:
            return LevelConfig(
                id: 9,
                waves: [
                    EggWaveConfigModel(
                        id: "l9wave1",
                        eggsCount: 40,
                        interval: 2,
                        startDelay: 0,
                        speedRange: 160...180,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.plain]
                    ),
                    EggWaveConfigModel(
                        id: "l9wave2",
                        eggsCount: 15,
                        interval: 5,
                        startDelay: 2,
                        speedRange: 80...100,
                        trajectories: [.parabola, .diagonal, .straight],
                        allowedEggKinds: [.magic]
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
