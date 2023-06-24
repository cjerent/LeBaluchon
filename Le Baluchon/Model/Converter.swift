//
//  Converter.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 19/06/2023.
//

import Foundation

struct CurrencyData: Decodable {
    let timestamp: Double?
    let quotes: [String:Double]?
}

struct Symbols: Decodable {
    let symbols: [String:String]?
}
