//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

import Foundation

class FakeResponseData {
    static let responseOk = HTTPURLResponse(url: URL(string:"http://apilayer.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string:"http://apilayer.net")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class ConverterServiceError: Error {}
    static let converterError = ConverterServiceError()
    
    static var converterCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyRates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let converterIncorrectData = "erreur".data(using: .utf8)!
//    static let imageData = "image".data(using: .utf8)!
    
    class TranslationServiceError: Error {}
    static let translationError = TranslationServiceError()
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let translationIncorrectData = "erreur".data(using: .utf8)!
    
    class WeatherServiceError: Error {}
    static let cityNameError = WeatherServiceError()
    
    static var cityNameCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let cityNameIncorrectData = "erreur".data(using: .utf8)!
    
    static let temperatureError = WeatherServiceError()
    
    static var temperatureCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let temperatureIncorrectData = "erreur".data(using: .utf8)!
    
    static let descriptionError = WeatherServiceError()
    
    static var descriptionCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let descriptionIncorrectData = "erreur".data(using: .utf8)!
    
    static let iconError = WeatherServiceError()
    
    static var iconCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let iconIncorrectData = "erreur".data(using: .utf8)!
    
    
    

    
}
