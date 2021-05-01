//
//  DictionaryExtension.swift
//  loc
//
//  Created by Сергей  Бей on 28.03.2021.
//

import Foundation

//MARK: - Printing Functions
var consoleIO = ConsoleInputOutput()
//functionality of outputting dictionary values to the console

extension Dictionary where Key == String, Value == [String : String] {
    
    ///получить все ключи и слова из словаря в виде строки
    
    func stringFromDictionary() -> String {
       
        guard !self.isEmpty else {
            consoleIO.writeMessage("Dictionary is empty!")
            return "Empty Dictionary"
        }
        var str = "\n"
        for key in self.keys {
            consoleIO.writeMessage("\(key)")
            str.append(key)
            for (key, value) in self[key]! {
                str.append("\n   \(key): \(value)")
            }
        }
        return str
    }
    
    ///получить слова по переданому ключу и языку
    mutating func stringWordBy(key: String, language: String) -> String {
        let notFound = "NOT_FOUND".localized
        var str = "\n"
        guard !key.isEmpty && !language.isEmpty else {
            return notFound
        }
        guard let dictionary = self[key] else {
            return notFound
        }
        guard let word = dictionary[language] else {
            return notFound
        }
        str.append(word)
        return str
    }
    
    /// получить слово по ключу
    mutating func stringWordsByKey(_ key: String) -> String {
        var str = "Not Found"
        guard !key.isEmpty else {
            return str
        }
        guard let value = self[key] else {
            return str
        }
        str = "\n"
        for key in value.keys {
            str.append("\n  \(key): \(value[key]!)")
        }
        return str
    }
    
    ///вернуть значения искомого языка
    func stringWordsByLanguage(_ language: String) -> String {
        var str = "\n"
        str.append(language)
        for key in self.keys {
            guard let word = self[key]?[language] else { continue }
            str.append("\n  \(key): \(word)")
        }
        return str
    }
    
}

//MARK: - Update Functions

//functionality for adding update and deleting values in the dictionary

extension Dictionary where Key == String, Value == [String : String] {
    
    ///adds or updates values
    mutating func update(word: String, by key: String, language: String) -> String {
        var str = "\n"
        if self.isEmpty {
            self = [key: [language: word]]
        } else if self[key] == nil {
            self[key] = [language: word]
        } else {
            self[key]?[language] = word
        }
        str.append(word)
        return str
    }
    
    ///удалить слово по ключу и языку
    mutating func deleteBy(key: String, language: String) -> String {
        guard !self.isEmpty else {
            return "Dictionary is empty! There is nothing to delete!"
        }
        var str = "\nValue '\(String(describing: self[key]?[language] ?? ""))' have been deleted!"
        self[key]?[language] = nil
        guard let byKeyIsEmpty = self[key]?.isEmpty else { return "" }
        if byKeyIsEmpty {
            self[key] = nil
            str = "Value '\(String(describing: self[key] ?? ["":""]))' have been deleted!"
        }
        return str
    }
    
    ///delete content by key
    mutating func deleteBy(key: String) -> String {
        var str = "\n"
        guard !self.isEmpty else {
            return "Dictionary is empty! There is nothing to delete!"
        }
        str.append("By key \(key) all values have been deleted!")
        self[key] = nil
        return str
        
    }
    
    ///delete content by key
    mutating func deleteBy(language: String) -> String {
        var str = "\n"
        guard !self.isEmpty else {
            return "Dictionary is empty! There is nothing to delete!"
        }
        for key in self.keys {
            for lan in self[key]!.keys {
                if language == lan {
                    str.append("Value '\(String(describing: self[key] ?? ["":""]))' have been deleted")
                    self[key] = nil
                }
            }
        }
        return str
    }
}



