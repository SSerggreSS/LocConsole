//
//  ViewController.swift
//  LocConsole
//
//  Created by Сергей  Бей on 29.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var localLabel: UILabel!
    
    let localizationHelper = LocalizationHelper()
    var requestForLocalization = "\(CommandType.search.rawValue)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localLabel.numberOfLines = 0
        localLabel.sizeToFit()
        localizationHelper.delegate = self
        setupUserInterface()
    }
    
    @IBAction func enterButtonAction(_ sender: UIButton) {
        requestForLocalization += " \(KeyType.key.rawValue) "
        requestForLocalization.append(textFields[0].text?.lowercased()  ?? "")
        requestForLocalization += " \(KeyType.language.rawValue) "
        requestForLocalization.append(textFields[1].text?.lowercased() ?? "")
        localizationHelper.consoleInputProcessing(mode: .staticMode,
                                                  text: requestForLocalization)
        requestForLocalization = "\(CommandType.search.rawValue)"
    }
    
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        textFields.forEach { tf in
            tf.text?.removeAll()
        }
        localLabel.text?.removeAll()
        textFields.first?.becomeFirstResponder()
        requestForLocalization = "\(CommandType.search.rawValue)"
    }
    
    func setupUserInterface() {
        enterButton.cornerRadius(10)
        clearButton.cornerRadius(10)
    }
}

//MARK: - LocalizationHelperDelegate

extension ViewController: LocalizationHelperDelegate {
    
    func sendWordsByKeyAndLanguage(string: String) {
        localLabel.text = string
    }
    
    func sendSearch(resultString: String) {
        localLabel.text = resultString
    }
    
}
