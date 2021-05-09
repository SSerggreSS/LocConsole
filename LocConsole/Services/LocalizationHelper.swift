//
//  LocalizationHelper.swift
//  loc
//
//  Created by Сергей  Бей on 13.03.2021.
//

import Foundation

protocol LocalizationHelperDelegate: AnyObject {
    
    /// отправить все занчения имеющиеся в словаре
    func sendSearch(resultString: String)
    
    /// отправить слова имеющиеся по искомому ключу и языку
    func sendWordsByKeyAndLanguage(string: String)
    
    // отправить слова по искомому языку
    func sendWordsByLanguage(_ string: String)
    
    /// отправить слова по искомогу ключу
      func sendWordsByKey(string: String)
    
//    func sendError(message: String)
//    func sendSuccessUpdate(message: String)
//    func sendSuccessDelete(message: String)
//    func sendHelp(message: String)
//    func sendGoodBy(message: String)
}

class LocalizationHelper {
    
    private var dictionary: [String : [String : String]] = {
        guard let dict = UserDefaults.standard.dictionaryStringsBy(key: Const.saveKey) else {
            return [
                "hello":["en":"Hello", "ru":"Привет", "ev":"היי.", "de":"Hallo"],
                "bye":["en":"Bye", "ru":"Пока", "ev":"ביי.", "de":"Hallo"]
            ]
        }
        return dict
    }()
    
    weak var delegate: LocalizationHelperDelegate? // Делегат всегда реализуем слабой ссылкой чтобы избежать утечек памяти
    private let consoleIO = ConsoleInputOutput()
    var command = CommandType.unowned
    var value = ""
    var shouldQuit = false
    
    //MARK: - Help function
    
    func getCommand(_ command: String) -> (option: CommandType, value: String) {
        return (CommandType(value: command), command)
    }
    
    func consoleInputProcessing(mode: ModeType, text: String) {
        
        if !mode.isStaticMode {
            consoleIO.printUsageInIteractiveMode()
        }
        
        shouldQuit = mode.isStaticMode
            
            let argumentsOfCommandLine = argumentsFor(mode: mode, text: text)
            
            let itemsCount = argumentsOfCommandLine.count
            var wordForUpdate = ""
            
            var firstKey = KeyType.unowned
            var firstParam = ""
            var secondKey = KeyType.unowned
            var secondParam = ""
            
            if itemsCount == 1 || itemsCount == 3 || itemsCount == 5 && itemsCount != 6 {
                let commandName = String(argumentsOfCommandLine[0])
                (command, value) = getCommand(commandName)
            } else if argumentsOfCommandLine.count == 6 {
                let commandName = String(argumentsOfCommandLine[0])
                (command, value) = getCommand(commandName)
                wordForUpdate = String(argumentsOfCommandLine[1])
                firstKey = KeyType(rawValue: String(argumentsOfCommandLine[2])) ?? .unowned
                firstParam = String(argumentsOfCommandLine[3])
                secondKey = KeyType(rawValue: String(argumentsOfCommandLine[4])) ?? .unowned
                secondParam = String(argumentsOfCommandLine[5])
            }
            
            
            if itemsCount >= 3 && itemsCount != 6 {
                firstKey = KeyType(rawValue: String(argumentsOfCommandLine[1])) ?? .unowned
                firstParam = String(argumentsOfCommandLine[2])
            }
            
            if itemsCount == 5 {
                secondKey = KeyType(rawValue: String(argumentsOfCommandLine[3])) ?? .unowned
                secondParam = String(argumentsOfCommandLine[4])
            }
            
            process(command: command, wordForUpdate: wordForUpdate, firstKey: firstKey,
                    secondKey: secondKey, firstParam: firstParam, secondParam: secondParam, itemsCount: itemsCount)
            

        
    }
    
}

//MARK: - Help Function

extension LocalizationHelper {
    
    ///take command line arguments depending on mode
    private func argumentsFor(mode: ModeType, text: String) -> [String] {
        print("\(#function) text = \(text)")
        var argumentsOfCommandLine: [String]
        switch mode {
        case .interactiveMode:
            let inputUser = readLine() ?? ""
            argumentsOfCommandLine = inputUser.split(separator: " ").map({ subStr in
                return String(subStr)
            })
        case .staticMode:
            let subStrings = text.split(separator: " ")
            argumentsOfCommandLine = subStrings.map({ subStr in
                return String(subStr)
            })
        }
        return argumentsOfCommandLine
    }
    
    ///processing a command with incoming keys and parameters
    private func process(command: CommandType, wordForUpdate: String,
                         firstKey: KeyType, secondKey: KeyType,
                         firstParam: String, secondParam: String, itemsCount: Int) {
        switch command {
        
        case .search where firstKey == .key && secondKey == .language:
            let string = dictionary.stringWordBy(key: firstParam, language: secondParam)
            delegate?.sendWordsByKeyAndLanguage(string: string)
        case .search where firstKey == .language && secondKey == .key:
            let string = dictionary.stringWordBy(key: secondParam, language: firstParam)
            delegate?.sendWordsByKeyAndLanguage(string: string)
        case .search where firstKey == .key:
            let string = dictionary.stringWordsByKey(firstParam)
            delegate?.sendWordsByKey(string: string)
        case .search where firstKey == .language:
            let string = dictionary.stringWordsByLanguage(firstParam)
            delegate?.sendWordsByLanguage(string)
        case .search where itemsCount < 2:
            let string = dictionary.stringFromDictionary()
            delegate?.sendSearch(resultString: string)
        case .update where firstKey == .key && secondKey == .language:
            let string = dictionary.update(word: wordForUpdate, by: firstParam, language: secondParam)
            //delegate?.sendSuccessUpdate(message: string)
            saveDictionaryInUserDefaults()
        case .delete where firstKey == .key && secondKey == .language:
            let string = dictionary.deleteBy(key: firstParam, language: secondParam)
            saveDictionaryInUserDefaults()
            //delegate?.sendSuccessDelete(message: string)
        case .delete where firstKey == .key:
            let string = dictionary.deleteBy(key: firstParam)
            //delegate?.sendSuccessDelete(message: string)
        case .delete where secondKey == .language:
            let string = dictionary.deleteBy(language: secondParam)
            //delegate?.sendSuccessDelete(message: string)
        case .delete:
            dictionary.removeAll()
            //delegate?.sendSuccessDelete(message: "Dictionary removed!!!")
            saveDictionaryInUserDefaults()
        case .unowned:
            consoleIO.writeMessage("I don't know that command \(value)",
                                   to: .error)
            consoleIO.writeMessage("For instruction enter command: help")
            let string = "I don't know that command '\(value)' \nFor instruction enter command: help"
            //delegate?.sendError(message: string)
        case .help:
            consoleIO.printHelp()
            //delegate?.sendHelp(message: "HELP".localized)
        case .q:
            shouldQuit = true
            //delegate?.sendGoodBy(message: "Good bay!")
        default:
            consoleIO.writeMessage("Not Found")
            consoleIO.writeMessage("For instruction enter command: help")
            let string = "Not Found \nFor instruction enter command: help"
            //delegate?.sendError(message: string)
            break
        }
    }
    
    private func saveDictionaryInUserDefaults() {
        UserDefaults.standard.setValue(dictionary, forKey: Const.saveKey)
    }
    
}
