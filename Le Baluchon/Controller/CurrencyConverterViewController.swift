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
    
    let converter = ConverterService()
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let myColor = UIColor.customViolet
        numberToConvertUITextField.layer.borderColor = myColor.cgColor
        numberToConvertUITextField.layer.cornerRadius = 5.0
        numberToConvertUITextField.layer.borderWidth = 1.0
        convertUIButton.layer.cornerRadius = 5.0
        
//        converter.getConversionRate()

   }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        numberToConvertUITextField.resignFirstResponder()
    }
    
    func displayConversion() {
        converter.getConversion { (success, conversion ) in
            guard let conversion = conversion, success == true else {
                return
            }
    //afficher resultat [string:Double] en string avec uniquement le montant converti
            var mystring = conversion.quotes?.values.description
            print(mystring)
            
//            newstring?.remove(at: newstring!.startIndex)
//            newstring?.dropFirst()
//            print("my str : \(newstring)")
            
//            self.numberConvertedUITextView.text
        
        }
    }
    
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        converter.reset()
        reset()
        let number = numberToConvertUITextField.text
        let currencyNameIndex = currenciesListUIPickerView.selectedRow(inComponent: 0)
        let currencyName = currenciesListJSON[currencyNameIndex]
        if let number = number {
        converter.addNumberToConvert(of: number )
        converter.addCurrencyNameToConvert(of: currencyName)
        }
       displayConversion()
        
        print(number ?? "")
        print(currencyName)
        
        
    }
    
    func reset() {
        numberConvertedUITextView.text.removeAll()
    }
}

 

extension CurrencyConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currenciesListJSON.count
    }
    
    
}



extension UIColor {
    static let customViolet = UIColor(red: 88/255.0, green: 112/255.0, blue: 247/255.0, alpha: 1)
}

extension CurrencyConverterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "American Typewriter", size: 25)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = currenciesListJSON[row]
        pickerLabel?.textColor = UIColor.customViolet
        return pickerLabel!
    }
}
