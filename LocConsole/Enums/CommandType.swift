//
//  OptionType.swift
//  loc
//
//  Created by Сергей  Бей on 28.03.2021.
//

import Foundation

enum CommandType: String {
    
    case search
    case update
    case delete
    case help
    case q
    case unowned
    
    init(value: String) {
        switch value {
        case "search": self = .search
        case "update": self = .update
        case "delete": self = .delete
        case "help"  : self = .help
        case "q"     : self = .q
        default      : self = .unowned
        }
    }
}
