//
//  EggKind.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 29.12.2025.
//

import Foundation

enum EggKind {
    case plain
    case magic
    case dynamite
    case sun
}

extension EggKind {
    var scoreDelta: Int {
        switch self {
        case .plain: return 1
        case .magic: return 5
        case .dynamite: return -20
        case .sun: return 10
        }
    }

    var countsAsMiss: Bool {
        switch self {
        case .plain, .magic: return true
        case .dynamite, .sun: return false
        }
    }
}
