//
//  ConsoleInputOutput.swift
//  loc
//
//  Created by Сергей  Бей on 13.03.2021.
//

import Foundation

enum OutputType {
    case standart
    case error
}

class ConsoleInputOutput {
    
    func printUsageInIteractiveMode() {
        
        writeMessage("Hi i am your localization assistant, i am very basic.")
        writeMessage("If you want to know the instructions enter command: help")
        
    }
    
    func printHelp() {
        
        writeMessage("usage:")
        let str =
            """
        in static mode:
        usage: loc [help] [search] [update] [delete] 
                   [<command> -k <key> -l <language>]
                   [update <word> -k <key> -l <language>]
        example search by key and language:
        input command: loc search -k hello -l en
        result: Hello
        in interactive mode without "loc"
        to exit enter the command: q
        """
        writeMessage(str)
    }
    
    func writeMessage(_ message: String, to: OutputType = .standart) {
        switch to {
        case .standart:
            print(message)
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
}

