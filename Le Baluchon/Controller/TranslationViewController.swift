//
//  TranslationViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet weak var sentenceToTranslateTextView: UITextView!
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let myColor = UIColor.customViolet
        sentenceToTranslateTextView.layer.borderColor = myColor.cgColor
        sentenceToTranslateTextView.layer.cornerRadius = 5.0
        sentenceToTranslateTextView.layer.borderWidth = 1.0
        

   }
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        sentenceToTranslateTextView.resignFirstResponder()
    }
}
