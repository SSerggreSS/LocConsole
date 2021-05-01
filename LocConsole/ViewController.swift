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
    @IBOutlet weak var textView: UITextView!
    
    let localizationHelper = LocalizationHelper()
    var textFromTextView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        localizationHelper.delegate = self
        setupUserInterface()
    }
    
    
    @IBAction func enterButtonAction(_ sender: UIButton) {
        localizationHelper.consoleInputProcessing(mode: .staticMode, text: textFromTextView)
    }
    
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        textView.text.removeAll()
        textView.text = "ENTER_TEXT".localized
    }
    
    func setupUserInterface() {
        enterButton.cornerRadius(10)
        clearButton.cornerRadius(10)
    }
}



//MARK: - UITextViewDelegate

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray2 {
            textView.text = nil
            textView.textColor = UIColor.systemGreen
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let nsString = textView.text as NSString
        let newString = nsString.replacingCharacters(in: range, with: text)
        textFromTextView = newString
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "ENTER_TEXT".localized
            textView.textColor = UIColor.systemGreen
        }
    }
    
}


//MARK: - LocalizationHelperDelegate

extension ViewController: LocalizationHelperDelegate {
    
    func sendHelp(message: String) {
        textView.text = message
    }
    
    func sendWordsByKeyAndLanguage(string: String) {
        textView.text = string
    }
    
    func sendWordsByLanguage(_ language: String) {
        textView.text = language
    }
    
    func sendWordsBy(key: String) {
        textView.text = key
    }
    
    func sendSearch(resultString: String) {
        textView.text = resultString
    }
    
    func sendSuccessUpdate(message: String) {
        textView.text = message
    }
    
    func sendSuccessDelete(message: String) {
        textView.text = message
    }
    
    func sendError(message: String) {
        textView.text = message
    }
    
    func sendGoodBy(message: String) {
        textView.text = message
    }
    
}
