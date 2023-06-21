//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
   
    @IBOutlet weak var numberToConvertUITextField: UITextField!
    @IBOutlet weak var currenciesListUIPickerView: UIPickerView!
    @IBOutlet weak var convertUIButton: UIButton!
    @IBOutlet weak var numberConvertedUITextView: UITextView!
   
    // ajouter nom de la monnaie au pickerview OK - Ajouter le timestamp -  grossir le montant converti - verifier les autres tailles - changer api
    
    let converter = ConverterService()
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let myColor = UIColor.customViolet
        numberToConvertUITextField.layer.borderColor = myColor.cgColor
        numberToConvertUITextField.layer.cornerRadius = 5.0
        numberToConvertUITextField.layer.borderWidth = 1.0
        convertUIButton.layer.cornerRadius = 5.0

   }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        numberToConvertUITextField.resignFirstResponder()
    }
    
    
    private func displayConversion() {
        converter.getConversion { (success, conversion ) in
            guard let conversion = conversion, success == true else {
                return
            }
            if let conversion = conversion.quotes?.values {
                let amount = Double(conversion.description.dropFirst().dropLast())
                self.numberConvertedUITextView.text = "\(amount?.roundedString ?? "") \(self.converter.convertTo)"
            }
        }
    }
    
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        converter.reset()
        resetDisplay()
        
        let numberTapped = numberToConvertUITextField.text
        
        if let numberTapped = numberTapped {
            converter.addNumberToConvert(from: numberTapped)
            converter.addCurrencyNameToConvert(from: getSelectedCurrency())
        } else {
            showAlert(title: "Erreur", message: "Veuillez entrer un nombre/chiffre à convertir")
        }
        
       displayConversion()
    }
    
    
    private func resetDisplay() {
        numberConvertedUITextView.text.removeAll()
    }
    
    private func getSelectedCurrency() -> String {
        let currencyNameIndex = currenciesListUIPickerView.selectedRow(inComponent: 0)
        let currencyName = currenciesListJSON[currencyNameIndex].code
        return currencyName
    }
    
    
}

 

