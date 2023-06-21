//
//  Converter.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 19/06/2023.
//

import Foundation

struct CurrencyRates: Decodable {
    let quotes: [String:Double]?
}

struct Symbols: Decodable {
    let symbols: [String:String]?
}
