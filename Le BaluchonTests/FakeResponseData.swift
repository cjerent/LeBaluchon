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
    static let error = ConverterServiceError()
    
    static var converterServiceCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyRates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let converterServiceIncorrectData = "erreur".data(using: .utf8)!
    static let imageData = "image".data(using: .utf8)!
    
    
}
