//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var numberToConvertUITextField: UITextField!
    @IBOutlet weak var currenciesListUIPickerView: UIPickerView!
    @IBOutlet weak var convertUIButton: UIButton!
    @IBOutlet weak var conversionResultUILabel: UILabel!
    @IBOutlet weak var lastUpdateDateUILabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var presentationUILabel: UILabel!
    
    // Custom colors
    let myPurple = UIColor.customPurple
    let myTurquoise = UIColor.customTurquoise
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyTextFieldStyle(of: numberToConvertUITextField)
        modifyButtonStyle(of: convertUIButton)
        modifyLabelStyle(of: conversionResultUILabel)
        modifyPresentationLabelStyle(of: presentationUILabel)
        
    }
    
    /// Dismiss keyboard if screen is tapped
    /// - Parameter sender: UITapGestureRecognizer
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        numberToConvertUITextField.resignFirstResponder()
    }
    
    /// Tapped convert button
    /// - Parameter sender: convertUIButton
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        ConverterService.shared.reset()
        resetDisplay()
        let numberTapped = numberToConvertUITextField.text
        if let numberTapped = numberTapped {
            if numberTapped == "" {
                showAlert(title: "⚠️", message: "Il faut d'abord mettre un nombre ou un chiffre pour la conversion 😅")
            } else {
                // send number to convert
                self.showActivityIndicator(hide: convertUIButton, show: activityIndicatorView)
                ConverterService.shared.addNumberToConvert(from: numberTapped)
                // send currency name to convert
                ConverterService.shared.addCurrencyNameToConvert(from: getSelectedCurrency())
                displayConversion()
            }
        }
    }
    
    /// Display conversion info
    private func displayConversion() {
        ConverterService.shared.getConversion { (success, conversion ) in
            self.hideActivityIndicator(hide: self.activityIndicatorView, show: self.convertUIButton)
            guard let conversion = conversion, success == true else {
                self.showAlert(title: "❌", message: "La conversion a échouée...Veuillez rééssayer 😥")
                return
            }
            self.displayConversionResult(of: conversion)
            self.displayRateLastUpdate(of: conversion)
        }
    }
    
    /// Display conversion result
    /// - Parameter conversion: quotes values (rates)
    private func displayConversionResult(of conversion: CurrencyData?) {
        if let conversion = conversion?.quotes?.values {
            let amount = Double(conversion.description.dropFirst().dropLast())
            self.conversionResultUILabel.text = "\(amount?.roundedString ?? "") \(ConverterService.shared.convertTo)"
        }
    }
    
    /// Display last rate update
    /// - Parameter conversion: timestamp
    private func displayRateLastUpdate(of conversion: CurrencyData?) {
        if let conversion = conversion?.timestamp {
            let date = self.formatDate(of: conversion)
            self.lastUpdateDateUILabel.text = date
        }
    }
    
    /// Reset display of conversionResultUILabel
    private func resetDisplay() {
        conversionResultUILabel.text = ""
    }
    
    /// Retrieve currency name to convert to send to ConverterService
    /// - Returns: String of currency name
    private func getSelectedCurrency() -> String {
        let currencyNameIndex = currenciesListUIPickerView.selectedRow(inComponent: 0)
        let currencyName = currenciesListJSON[currencyNameIndex].code
        return currencyName
    }
    
    /// Custom UITextField style
    /// - Parameter textField: UITextField
    private func modifyTextFieldStyle(of textField: UITextField) {
        textField.layer.borderColor = myPurple.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
    }
    
    /// Custom UIButton style
    /// - Parameter button: UIButton
    private func modifyButtonStyle(of button: UIButton) {
        button.layer.cornerRadius = 5.0
    }
    
    /// Custom UILabel style
    /// - Parameter label: UILabel
    private func modifyLabelStyle(of label: UILabel) {
        label.layer.borderWidth = 1.0
        label.layer.borderColor = myTurquoise.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
    }
    
    /// Custom presentationUILabel style
    /// - Parameter label: presentationUILabel
    private func modifyPresentationLabelStyle(of label: UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
    }
    
    
    /// Format timestamp double in String Date
    /// - Parameter timestamp: Double (timestamp)
    /// - Returns: String (Date)
    private func formatDate(of timestamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy à HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}





