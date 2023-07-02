//
//  ConverterService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 19/06/2023.
//

import Foundation
import UIKit

class ConverterService {

    // Api key
    static private let fixerApi = valueForAPIKey(named: "fixerApi")
    // Conversion api url
    private let conversionRateUrl = URL(string: "http://apilayer.net/api/live?access_key=\(fixerApi)")!
    // Converter properties
    private var convertFrom: String = ""
    let convertTo: String = "USD"
    private var numberToConvert: Double = 0
    private var resultConverted: Double = 0
    
    //Task
    private var task: URLSessionDataTask?
    //Session
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    
    /// Add number tapped in numberToConvert
    /// - Parameter textField: addNumberToConvert in CurrencyConverterVC
    func addNumberToConvert(from textField: String) {
        let numberTapped = textField
        numberToConvert = numberTapped.doubleValue
        
    }
    
    /// Add selected currency in convertFrom
    /// - Parameter pickerViewString: addCurrencyNameToConvert in CurrencyConverterVC
    func addCurrencyNameToConvert(from pickerViewString: String) {
        convertFrom.append("USD\(pickerViewString)")
    }
    
    
    /// Empty numberToConvert and convertFrom
    func reset() {
        numberToConvert = 0.0
        convertFrom.removeAll()
    }
    
    /// Get conversion rates API Call 
    /// - Parameter callback: Bool and CurrencyData type
    func getConversion(callback: @escaping (Bool, CurrencyData?) -> Void) {
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
                self.createTimestampObjectToSend(data: data, callback: callback)
                self.createConversionResultObjectToSend(with: data, callback: callback)
                
            }
        }
        task?.resume()
    }
    
    /// Create timestamp object to send in callback
    /// - Parameters:
    ///   - data: API data timestamp
    ///   - callback: Bool and CurrencyData type
    private func createTimestampObjectToSend(data: Data, callback: @escaping (Bool, CurrencyData?) -> Void) {
        let currencyDataJSON = try? JSONDecoder().decode(CurrencyData.self, from: data);
        if let currencyDataJSON = currencyDataJSON?.timestamp {
            let timestamp = currencyDataJSON
            let conversionDate = CurrencyData(timestamp: timestamp, quotes: nil)
            callback(true, conversionDate)
        }
    }
    
    /// Create conversion result object to send in callback
    /// - Parameters:
    ///   - data: API data quotes
    ///   - callback: Bool and CurrencyData type
    private func createConversionResultObjectToSend(with data: Data, callback: @escaping (Bool, CurrencyData?) -> Void) {
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
    
    /// Calculate rate conversion - The free api only authorizes conversion from USD. So, you need to divide the USD to Convert from rate with numberToConvert to get the right result.
    /// - Parameter currencyRate: Double from API
    func calculateConversionRate(with currencyRate: Double) {
            self.resultConverted = numberToConvert/currencyRate
    }
    
}
