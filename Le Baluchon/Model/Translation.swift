//
//  Translation.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 13/06/2023.
//

import Foundation


//Struct for Google translation API
struct TranslationData: Decodable {
    let data : DataType?
}

struct DataType: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String?
    let detectedSourceLanguage: String?
}

// Struct for TranslationLanguageslist.swift
struct LanguageList: Codable {
    let languages: [LanguageName]
}

struct LanguageName: Codable {
    let language: String?
    let name: String?
}







