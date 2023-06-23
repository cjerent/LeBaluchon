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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    
    // ajouter nom de la monnaie au pickerview OK - Ajouter le timestamp OK -  grossir le montant converti OK- verifier les autres tailles OK - Ajouter alert si pas de montant-  ajouter activitycontroller - changer api
    let myPurple = UIColor.customPurple
    let myTurquoise = UIColor.customTurquoise
    
    override func viewDidLoad() {
      super.viewDidLoad()
        modifyTextFieldStyle(of: numberToConvertUITextField)
        modifyButtonStyle(of: convertUIButton)
        modifyLabelStyle(of: conversionResultUILabel)
        
   }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        numberToConvertUITextField.resignFirstResponder()

    }
    

    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        self.showActivityIndicator(hide: convertUIButton, show: activityIndicatorView)
        ConverterService.shared.reset()
        resetDisplay()
        
        let numberTapped = numberToConvertUITextField.text
        
        if let numberTapped = numberTapped {
            ConverterService.shared.addNumberToConvert(from: numberTapped)
            ConverterService.shared.addCurrencyNameToConvert(from: getSelectedCurrency())
        }
    
       displayConversion()

    }
    
    private func displayConversion() {
        ConverterService.shared.getConversion { (success, conversion ) in
            self.hideActivityIndicator(hide: self.activityIndicatorView, show: self.convertUIButton)
            guard let conversion = conversion, success == true else {
                self.showAlert(title: "Erreur", message: "La conversion a échouée...Veuillez rééssayer 😥")
                return
            }
            if let conversion = conversion.quotes?.values {
                let amount = Double(conversion.description.dropFirst().dropLast())
                self.conversionResultUILabel.text = "\(amount?.roundedString ?? "") \(ConverterService.shared.convertTo)"
            }
            
            if let conversion = conversion.timestamp {
                let date = self.formatDate(of: conversion)
                self.lastUpdateDateUILabel.text = date
                print(date)
            }
        
        }
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



 

