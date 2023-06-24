//
//  TranslationViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class TranslationViewController: UIViewController {
    
    //    IBOutlets
    @IBOutlet weak var toTranslateUITextView: UITextView!
    @IBOutlet weak var toDisplayTranslationUITextView: UITextView!
    @IBOutlet weak var languageNameToTranslateUILabel: UILabel!
    @IBOutlet weak var translationUIButton: UIButton!
    @IBOutlet weak var presentationUIStackView: UIStackView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyStackViewStyle(of: presentationUIStackView)
        modifyTextViewStyle(of: toDisplayTranslationUITextView)
        modifyTextViewStyle(of: toTranslateUITextView)
    }
    
    /// Dismiss keyboard if screen is tapped
    /// - Parameter sender: UITapGestureRecognizer
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        toTranslateUITextView.resignFirstResponder()
        toDisplayTranslationUITextView.resignFirstResponder()
    }
    
    /// Tapped translationUIButton
    /// - Parameter sender: translationUIButton
    @IBAction func tappedTranslationButton(_ sender: UIButton) {
        if toTranslateUITextView.text == "" {
            self.showAlert(title: "⚠️", message: "Tu dois indiquer un mot ou une phrase à traduire 😅")
        } else {
            self.showActivityIndicator(hide: translationUIButton, show: activityIndicatorView)
            TranslationService.shared.addTextToTranslate(of: toTranslateUITextView.text)
            displayTranslation()
        }
    }
    
    /// Display translation info
    private func displayTranslation() {
        TranslationService.shared.getTranslation { (success, translation ) in
            self.hideActivityIndicator(hide: self.activityIndicatorView, show: self.translationUIButton)
            guard let translation = translation, success == true else {
                self.showAlert(title: "Erreur", message: "Une traduction est déjà en cours 😥")
                return
            }
            self.displayDetectedLanguage(of: translation)
            self.displayTranslatedSentence(of:translation)
        }
    }
    
    /// Display translated sentence in toDisplayTranslationUITextView
    /// - Parameter translation: translatedText
    private func displayTranslatedSentence(of translation: Translation?) {
        TranslationService.shared.reset()
        toDisplayTranslationUITextView.text = translation?.translatedText
    }
    
    /// Display dtected language in languageNameToTranslateUILabel
    /// - Parameter translation: detectedSourceLanguage
    private func displayDetectedLanguage(of translation: Translation?) {
        languageNameToTranslateUILabel.text = translation?.detectedSourceLanguage
    }
    
    /// Custom UIStackView style
    /// - Parameter stackView: UIStackView
    private func modifyStackViewStyle(of stackView: UIStackView) {
        stackView.layer.cornerRadius = 5.0
    }
    
    /// Custom UITextView style
    /// - Parameter textView: UITextView
    private func modifyTextViewStyle(of textView: UITextView) {
        let customPurple = UIColor.customPurple
        textView.layer.borderColor = customPurple.cgColor
        textView.layer.cornerRadius = 5.0
        textView.layer.borderWidth = 2.0
    }
    
}
