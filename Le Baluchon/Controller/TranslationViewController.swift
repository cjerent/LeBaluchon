//
//  TranslationViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class TranslationViewController: UIViewController {


 
    @IBOutlet weak var toTranslateUITextView: UITextView!
    @IBOutlet weak var toDisplayTranslationUITextView: UITextView!
    @IBOutlet weak var languageNameToTranslateUILabel: UILabel!
    @IBOutlet weak var translationUIButton: UIButton!
    
    @IBOutlet weak var presentationUIStackView: UIStackView!
    var translate = TranslationService()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        modifyStackViewStyle(of: presentationUIStackView)
        modifyTextViewStyle(of: toDisplayTranslationUITextView)
        modifyTextViewStyle(of: toTranslateUITextView)
   }
   

    
    private func modifyTextViewStyle(of textView: UITextView) {
        let customPurple = UIColor.customViolet
        textView.layer.borderColor = customPurple.cgColor
         textView.layer.cornerRadius = 5.0
          textView.layer.borderWidth = 2.0
    }
    
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        toTranslateUITextView.resignFirstResponder()
        toDisplayTranslationUITextView.resignFirstResponder()
    }
    
    @IBAction func tappedTranslationButton(_ sender: UIButton) {
        translate.addTextToTranslate(of: toTranslateUITextView.text)
        
       
        displayTranslation()
    }
    
    func displayTranslation() {
        
        translate.getTranslation { (success, translation ) in
            guard let translation = translation, success == true else {
                
                return
            }
            
            self.languageNameToTranslateUILabel.text = translation.detectedSourceLanguage
            self.updateTranslation(translation)
        }
    }
    
    private func updateTranslation(_ translation: Translation) {
        translate.reset()
        toDisplayTranslationUITextView.text = translation.translatedText
        
        
    }
    
    private func modifyStackViewStyle(of stackView: UIStackView) {
         stackView.layer.cornerRadius = 5.0
    }
    



}
