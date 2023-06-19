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
    let conversionRateUrl = URL(string: "http://apilayer.net/api/live?access_key=e3fe8aa46ebb20eae8ae47803214411d")!
    static var convertFrom: String = ""
    static var convertTo: String = "USD"
    var numberConverted: String = ""
    var numberToConvert: String = ""
    
    
    private var task: URLSessionDataTask?
    
    func addNumberToConvert(of textField: String) {
        
        let numb = textField
        numberToConvert.append(numb)
        print("numb: \(numb)")
        
        
    }
    
    
    func addCurrencyNameToConvert(of pickerView: String) {
        ConverterService.convertFrom.append(pickerView)
        print("currency from: \(ConverterService.convertFrom)")
        
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
                        //                        print("name: \(name) qui vaut \(value) USD")
                        if currencyName.contains("USD\(ConverterService.convertFrom)"){
                            let result = Double(self.numberToConvert)!/currencyRate
                            self.numberConverted.append(String(result))
                            
                            let conversionResult = CurrencyRates(quotes: [currencyName:result])
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
        ConverterService.convertTo.removeAll()
        ConverterService.convertFrom.removeAll()
    }
    
    
    
}
