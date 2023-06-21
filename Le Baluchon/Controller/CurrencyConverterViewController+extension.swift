//
//  CurrencyConverterViewController+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 20/06/2023.
//

import Foundation
import UIKit


extension CurrencyConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currenciesListJSON.count
    
    }
    
    
}




extension CurrencyConverterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "American Typewriter", size: 25)
            pickerLabel?.textAlignment = .center
        }

        pickerLabel?.text = "\(currenciesListJSON[row].code) - \(currenciesListJSON[row].name)"
        pickerLabel?.textColor = UIColor.customViolet
        return pickerLabel!
    }
    
}
