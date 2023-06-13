//
//  TranslationViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class TranslationViewController: UIViewController {


    @IBOutlet weak var toTranslateUITextField: UITextField!
    @IBOutlet weak var toDisplayTranslationUITextView: UITextView!
    
    
    var translate = TranslationService()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        modifyTextViewStyle(of: toDisplayTranslationUITextView)
        modifyTextFieldStyle(of: toTranslateUITextField)
        
        displayTranslation()
       
   }
   
    
    private func modifyTextFieldStyle(of textField: UITextField) {
        let customPurple = UIColor.customViolet
        textField.layer.borderColor = customPurple.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 2.0
        
    }
    
    private func modifyTextViewStyle(of textView: UITextView) {
        let customPurple = UIColor.customViolet
        textView.layer.borderColor = customPurple.cgColor
         textView.layer.cornerRadius = 5.0
          textView.layer.borderWidth = 2.0
    }
    
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        toTranslateUITextField.resignFirstResponder()
        toDisplayTranslationUITextView.resignFirstResponder()
    }
    
    func displayTranslation() {
        translate.getTranslation { (success, translation ) in
            guard let translation = translation, success == true else {
                
                return
            }
            self.updateTranslation(translation)
        }
    }
    
    private func updateTranslation(_ translation: Translation) {
        toDisplayTranslationUITextView.text = translation.translatedText
    }


}
