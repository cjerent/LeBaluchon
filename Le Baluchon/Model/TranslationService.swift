//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 13/06/2023.
//

import Foundation




class TranslationService {
    var googleTranslateAPI = valueForAPIKey(named: "googleTranslateAPI")
    var translationUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    var source: String = "fr"
    var target: String = "en"
    var textToTranslate: String = "Bonjour comment vas tu ?"
    
    private var task: URLSessionDataTask?
    
    
    func getTranslation(callback: @escaping (Bool, Translation?) -> Void) {
        var request = URLRequest(url: translationUrl)
        request.httpMethod = "POST"
        let body = "q=\(textToTranslate)&target=\(target)&source=\(source)&key=\(googleTranslateAPI)"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                print(request)
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
        
                let translationResponse = try? JSONDecoder().decode(TranslationData.self, from: data);
                
                if let translationResponse = translationResponse?.data?.translations {
                    for i in translationResponse {
                        if let text = i.translatedText {
                           let text = text
                            print(text)
                            let textTranslated = Translation(translatedText: text)
                            callback(true, textTranslated)
                        }
                    }
                }

            }
        }
        if let task = task {
            task.resume()
        }
        
    }
}
