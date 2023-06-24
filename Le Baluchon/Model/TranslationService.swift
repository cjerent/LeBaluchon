//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 13/06/2023.
//

import Foundation
import UIKit


class TranslationService {
    // Singleton pattern
    static var shared = TranslationService()
    private init() {}
    // Api key
    let googleTranslateAPI = valueForAPIKey(named: "googleTranslateAPI")
    //Google translate api url
    let translationUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    //Google translate api url params
    let target: String = "en"
    let format: String = "text"
    //// Translation properties
    var textToTranslate: String = ""
    
    //Unique task
    private var task: URLSessionDataTask?
    
    
    /// Add text tapped in textToTranslate
    /// - Parameter textView: String to translate
    func addTextToTranslate(of textView: String) {
        textToTranslate.append(contentsOf: textView)
    }
    
    /// Empty textToTranslate
    func reset() {
        textToTranslate.removeAll()
    }
    
    
    /// Get translation API Call
    /// - Parameter callback: Bool and Translation
    func getTranslation(callback: @escaping (Bool, Translation?) -> Void) {
        var request = URLRequest(url: translationUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTranslate)&target=\(target)&format=\(format)&key=\(googleTranslateAPI)"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                self.createTranslationObjectToSend(with: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    
    /// Create translation object to send in callback
    /// - Parameters:
    ///   - data: API data translation
    ///   - callback: Bool and Translation
    private func createTranslationObjectToSend(with data: Data,callback: @escaping (Bool, Translation?) -> Void ) {
        let translationResponse = try? JSONDecoder().decode(TranslationData.self, from: data);
        
        if let translationResponse = translationResponse?.data?.translations {
            for i in translationResponse {
                if let text = i.translatedText, let detected = i.detectedSourceLanguage {
                    let translatedText = text
                    let detectedLang = detected
                    detectSourceLanguage(of: TranslationLanguagesListJSON!, detectedLanguage: detectedLang, translatedText: translatedText, callback: callback)
                }
            }
        }
    }
    
    /// Detect translation source language in Translation Language list
    /// - Parameters:
    ///   - JSONData: TranslationLanguagelist.swift
    ///   - detectedLanguage: String
    ///   - translatedText: String
    ///   - callback: Bool and Translation
    private func detectSourceLanguage( of JSONData: Data, detectedLanguage : String, translatedText: String,callback: @escaping (Bool, Translation?) -> Void  ) {
        do {
            let languageData = try? JSONDecoder().decode(LanguageList.self, from: JSONData)
            if let languageData = languageData?.languages{
                for i in languageData {
                    if let code = i.language, let name = i.name {
                        let languageCode = code
                        let languageName = name
                        if languageCode.contains(detectedLanguage) {
                            let textTranslated = Translation(translatedText: translatedText, detectedSourceLanguage: languageName)
                            callback(true, textTranslated)
                        }
                    }
                }
            }
        }
    }
}
