//
//  ViewController.swift
//  LocConsole
//
//  Created by Сергей  Бей on 29.04.2021.
//

import UIKit

class LocalizationViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var localLabel: UILabel!
    
    // MARK: - Properties
    let localizationHelper = LocalizationHelper()
    var requestForLocalization = "\(CommandType.search.rawValue)"
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizationHelper.delegate = self
        setupUserInterface()
    }
    
    //MARK: IB Actions

    @IBAction func enterButtonAction(_ sender: UIButton) {

        let key = keyTextField.text ?? ""
        let language = languageTextField.text ?? ""
    
        if !key.isEmpty {
            requestForLocalization += " \(KeyType.key.rawValue) "
            requestForLocalization.append(keyTextField.text?.lowercased()  ?? "")
        }
        
        if !language.isEmpty {
            requestForLocalization += " \(KeyType.language.rawValue) "
            requestForLocalization.append(languageTextField.text?.lowercased() ?? "")
        }
    
        localizationHelper.consoleInputProcessing(mode: .staticMode,
                                                  text: requestForLocalization)
        requestForLocalization = "\(CommandType.search.rawValue)"
    }
    
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        clearAll()
    }
    
}

//MARK: - Help Functions

extension LocalizationViewController {
    
    private func setupUserInterface() {
        enterButton.cornerRadius(10)
        clearButton.cornerRadius(10)
        localLabel.numberOfLines = 0
        localLabel.sizeToFit()
    }
    
    private func clearAll() {
        localLabel.text?.removeAll()
        keyTextField.text?.removeAll()
        languageTextField.text?.removeAll()
        keyTextField.becomeFirstResponder()
        requestForLocalization = "\(CommandType.search.rawValue)"
    }
}

//MARK: - LocalizationHelperDelegate

extension LocalizationViewController: LocalizationHelperDelegate {
    
    
    func sendWordsByKeyAndLanguage(string: String) {
        localLabel.text = string
    }
    
    func sendSearch(resultString: String) {
        localLabel.text = resultString
    }
    
    func sendWordsByKey(string: String) {
        localLabel.text = string
    }
    
    func sendWordsByLanguage(_ string: String) {
        localLabel.text = string
    }
}

