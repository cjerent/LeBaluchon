//
//  Translation.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 13/06/2023.
//

import Foundation



struct TranslationData: Decodable {
    let data : DataType?
}

struct DataType: Decodable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String?
}



