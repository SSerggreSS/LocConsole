//
//  ModeType.swift
//  loc
//
//  Created by Сергей  Бей on 26.03.2021.
//

import Foundation

enum ModeType {

    case interactiveMode
    case staticMode
    
}

extension ModeType {
    var isStaticMode: Bool {
        switch self {
        case .interactiveMode:
            return false
        case .staticMode:
            return true
        }
    }
}


