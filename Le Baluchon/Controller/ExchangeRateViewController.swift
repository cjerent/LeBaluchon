//
//  ExchangeRateViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let myColor = UIColor.customViolet
        numberTextField.layer.borderColor = myColor.cgColor
        numberTextField.layer.cornerRadius = 5.0
        numberTextField.layer.borderWidth = 1.0
        convertButton.layer.cornerRadius = 5.0

   }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        numberTextField.resignFirstResponder()
    }
}



extension ExchangeRateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }
    
    
}



extension UIColor {
    static let customViolet = UIColor(red: 88/255.0, green: 112/255.0, blue: 247/255.0, alpha: 1)
}

extension ExchangeRateViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "American Typewriter", size: 30)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = currencies[row]
        pickerLabel?.textColor = UIColor.customViolet
        return pickerLabel!
    }
}
