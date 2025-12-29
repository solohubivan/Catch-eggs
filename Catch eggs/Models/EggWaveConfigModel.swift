//
//  EggWaveConfigModel.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//
import Foundation

struct EggWaveConfigModel {
    let id: String
    let eggsCount: Int
    let interval: TimeInterval
    let startDelay: TimeInterval
    let speedRange: ClosedRange<CGFloat>
    let trajectories: [EggTrajectory]
    let allowedEggKinds: [EggKind]
}

enum EggTrajectory {
    case straight
    case diagonal
    case parabola
}
