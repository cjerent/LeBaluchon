//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

import Foundation

class FakeResponseData {
    static let responseOk = HTTPURLResponse(url: URL(string:"https://test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string:"https://test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
 
    //    CONVERTER RESPONSE
    class ConverterServiceError: Error {}
    static let converterError = ConverterServiceError()
    
    static var converterCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyRates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let converterIncorrectData = "erreur".data(using: .utf8)!
    
    //    TRANLATION RESPONSE
    class TranslationServiceError: Error {}
    static let translationError = TranslationServiceError()
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let translationIncorrectData = "erreur".data(using: .utf8)!
    
    //    CITY NAME RESPONSE
    class WeatherServiceError: Error {}
    static let cityNameError = WeatherServiceError()
    
    static var cityNameCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let cityNameIncorrectData = "erreur".data(using: .utf8)!
    
    //    TEMPERATURE RESPONSE
    static let temperatureError = WeatherServiceError()
    
    static var temperatureCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let temperatureIncorrectData = "erreur".data(using: .utf8)!
    
    //    WEATHER DESCRIPTION RESPONSE
    static let descriptionError = WeatherServiceError()
    
    static var descriptionCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let descriptionIncorrectData = "erreur".data(using: .utf8)!
    
    //    ICON RESPONSE
    static let iconError = WeatherServiceError()
    
    static var iconCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let iconIncorrectData = "erreur".data(using: .utf8)!
    
    
    

    
}
