//
//  StringExtension.swift
//  loc
//
//  Created by Сергей  Бей on 28.03.2021.
//

import Foundation

extension String {
    //TODO - For Localization
    var localized: String {
            return NSLocalizedString(self, tableName: "", bundle: Bundle.main, value: "", comment: "Localizable")
        }
    
}
