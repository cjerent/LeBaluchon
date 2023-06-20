//
//  ConverterService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 19/06/2023.
//

import Foundation
import UIKit

class ConverterService {
    static let fixerApi = valueForAPIKey(named: "fixerApi")
    let conversionRateUrl = URL(string: "http://apilayer.net/api/live?access_key=\(fixerApi)")!
    var convertFrom: String = ""
    let convertTo: String = "USD"
    var numberToConvert: String = ""
    var resultConverted: Double = 0.0
    
    
    private var task: URLSessionDataTask?
    
    func addNumberToConvert(from textField: String) {
        let numberTapped = textField
        numberToConvert.append(numberTapped)
    }
    
    
    func addCurrencyNameToConvert(from pickerView: String) {
        convertFrom.append("USD\(pickerView)")
        print("currency from: \(convertFrom)")
    }
    
    func getConversion(callback: @escaping (Bool, CurrencyRates?) -> Void) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: conversionRateUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                let currencyDataJSON = try? JSONDecoder().decode(CurrencyRates.self, from: data);
                
                if let currencyDataJSON = currencyDataJSON?.quotes {
                    
                    for (key, value) in currencyDataJSON {
                        let currencyName = key
                        let currencyRate = value
                    
                        if currencyName.contains(self.convertFrom){
                            
                            if let numberToConvert = Double(self.numberToConvert){
                            self.resultConverted = numberToConvert/currencyRate
                            } else {
                                callback(false, nil)
                            }
                           
                            let conversionResult = CurrencyRates(quotes: [self.convertTo:self.resultConverted])
                                    callback(true, conversionResult)
                                    print("ConversionResult: \(conversionResult)")
                            

                            }
                    }
                }
            }
        }
        if let task = task {
            task.resume()
        }
    }
    
    
    func reset() {
        numberToConvert.removeAll()
        convertFrom.removeAll()
    }

    
    
}
