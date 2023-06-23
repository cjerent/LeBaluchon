//
//  ConverterService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 19/06/2023.
//

import Foundation
import UIKit

class ConverterService {
    static var shared = ConverterService()
    private init() {}
    
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
    }
    
    func reset() {
        numberToConvert.removeAll()
        convertFrom.removeAll()
    }
    
    func getConversion(callback: @escaping (Bool, CurrencyData?) -> Void) {
        let session = URLSession(configuration: .default)
        task?.cancel()
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
                self.createConversionResultToSend(data: data, callback: callback)
                self.createTimestampToSend(data: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    private func createTimestampToSend(data: Data, callback: @escaping (Bool, CurrencyData?) -> Void) {
        let currencyDataJSON = try? JSONDecoder().decode(CurrencyData.self, from: data);
        
        if let currencyDataJSON = currencyDataJSON?.timestamp {
            let timestamp = currencyDataJSON
            
            let conversionDate = CurrencyData(timestamp: timestamp, quotes: nil)
            callback(true, conversionDate)
            
        }
    }
    
    private func createConversionResultToSend(data: Data, callback: @escaping (Bool, CurrencyData?) -> Void) {
        let currencyDataJSON = try? JSONDecoder().decode(CurrencyData.self, from: data);
        
        if let currencyDataJSON = currencyDataJSON?.quotes {
            for (key, value) in currencyDataJSON {
                let currencyName = key
                let currencyRate = value
                if currencyName.contains(self.convertFrom){
                    calculateConversionRate(with: currencyRate)
                    let conversionResult = CurrencyData(timestamp: nil, quotes: [self.convertTo:self.resultConverted] )
                    callback(true, conversionResult)
                }
            }
        }
    }
    
    private func calculateConversionRate(with currencyRate: Double) {
        if let numberToConvert = Double(self.numberToConvert){
            self.resultConverted = numberToConvert/currencyRate
        }
    }
    
    
}
