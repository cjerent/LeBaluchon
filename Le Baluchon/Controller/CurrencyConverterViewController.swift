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
    @IBOutlet weak var conversionResultUILabel: UILabel!
    @IBOutlet weak var lastUpdateDateUILabel: UILabel!
    
    // ajouter nom de la monnaie au pickerview OK - Ajouter le timestamp OK -  grossir le montant converti OK- verifier les autres tailles OK - ajouter activitycontroller - changer api
    let myPurple = UIColor.customPurple
    let myTurquoise = UIColor.customTurquoise
    let converter = ConverterService()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        modifyTextFieldStyle(of: numberToConvertUITextField)
        modifyButtonStyle(of: convertUIButton)
        modifyLabelStyle(of: conversionResultUILabel)
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
                self.conversionResultUILabel.text = "\(amount?.roundedString ?? "") \(self.converter.convertTo)"
            }
            
            if let conversion = conversion.timestamp {
                let date = self.formatDate(of: conversion)
                self.lastUpdateDateUILabel.text = date
                print(date)
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
        conversionResultUILabel.text = ""
    }
    
    private func getSelectedCurrency() -> String {
        let currencyNameIndex = currenciesListUIPickerView.selectedRow(inComponent: 0)
        let currencyName = currenciesListJSON[currencyNameIndex].code
        return currencyName
    }
    
    private func modifyTextFieldStyle(of textField: UITextField) {
        textField.layer.borderColor = myPurple.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
    }
    
    private func modifyButtonStyle(of button: UIButton) {
        button.layer.cornerRadius = 5.0
    }
    
    private func modifyLabelStyle(of label: UILabel) {
        label.layer.borderWidth = 1.0
        label.layer.borderColor = myTurquoise.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
    }
    
    private func formatDate(of timestamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy à HH:mm:ss"//Specify your format that you want
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
   

    

}



 

