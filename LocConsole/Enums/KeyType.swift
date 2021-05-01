//
//  KeyType.swift
//  loc
//
//  Created by Сергей  Бей on 28.03.2021.
//

import Foundation

enum KeyType: String {
    
    case key = "-k"
    case language = "-l"
    case unowned
    
    init(value: String) {
        switch value {
        case "-k": self = .key
        case "-l": self = .language
        default: self = .unowned
        }
    }
}
