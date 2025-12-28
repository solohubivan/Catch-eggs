//
//  Font+App.swift
//  Catch eggs
//
//  Created by Ivan Solohub on 18.12.2025.
//

import SwiftUI

extension Font {
    
    static func rubikMonoOne(_ weight: RubikMonoOneWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    enum RubikMonoOneWeight: String {
        case regular = "RubikMonoOne-Regular"
    }
}

