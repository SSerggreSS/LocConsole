//
//  UserDefaultsExtension.swift
//  loc
//
//  Created by Сергей  Бей on 28.03.2021.
//

import Foundation

extension UserDefaults {
    
    func dictionaryStringsBy(key: String) -> [String : [String : String]]? {
        
        guard let dictionary = self.dictionary(forKey: key) as? [String : [String : String]] else {
            print("\(#filePath)\(#function) failed to convert data to [String : [String : String]]")
            return nil
        }
        return dictionary
    }
    
}
