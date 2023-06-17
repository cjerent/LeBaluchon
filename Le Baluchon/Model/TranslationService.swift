//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 13/06/2023.
//

import Foundation
import UIKit


class TranslationService {
    let googleTranslateAPI = valueForAPIKey(named: "googleTranslateAPI")
    let translationUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    let target: String = "en"
    let format: String = "text"
    
    var textToTranslate: String = ""
    
    
    
    private var task: URLSessionDataTask?
    
    
    func getTranslation(callback: @escaping (Bool, Translation?) -> Void) {
        
        var request = URLRequest(url: translationUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTranslate)&target=\(target)&format=\(format)&key=\(googleTranslateAPI)"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
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
                self.createObjectToSendToDisplay(with: data, callback: callback)
            }
        }
        if let task = task {
            task.resume()
        }
    }
    
    
    private func createObjectToSendToDisplay(with data: Data,callback: @escaping (Bool, Translation?) -> Void ) {
        let translationResponse = try? JSONDecoder().decode(TranslationData.self, from: data);
        
        if let translationResponse = translationResponse?.data?.translations {
            for i in translationResponse {
                if let text = i.translatedText, let detected = i.detectedSourceLanguage {
                    let translatedText = text
                    let detectedLang = detected
                    
                    decodeJSONDataToDetectLanguage(of: TranslationLanguagesListJSON!, detectedLang: detectedLang, text: translatedText, callback: callback)
                }
            }
        }
    }
    
    
    private func decodeJSONDataToDetectLanguage( of JSONData: Data, detectedLang : String, text: String,callback: @escaping (Bool, Translation?) -> Void  ) {
        do {
            let languageData = try? JSONDecoder().decode(LanguageList.self, from: JSONData)
            if let languageData = languageData?.languages{
                for i in languageData {
                    if let code = i.language, let name = i.name {
                        let langCode = code
                        let langName = name
                        if langCode.contains(detectedLang) {
                            let textTranslated = Translation(translatedText: text, detectedSourceLanguage: langName)
                            callback(true, textTranslated)
                        }
                    }
                }
            }
        }
    }
    
    
    func addTextToTranslate(of textView: String) {
        textToTranslate.append(contentsOf: textView)
    }
    
    func reset() {
        textToTranslate.removeAll()
    }
    
    
}
