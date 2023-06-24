//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 07/06/2023.
//

import Foundation




class WeatherService {
    // Singleton pattern
    static var shared = WeatherService()
    private init() {}
    // Api key
    static let openWeatherApi = valueForAPIKey(named: "openWeatherApi")
    // the list of cities included in the api is available in the WeatherCityList.swift file
    static var firstCityName: String = "New York"
    static let secondCityName: String = "Paris"
    // Add %20 for spaces in city name for the url
    static let firstCityNameWithEncoding: String = firstCityName.encodeString()
    static let secondCityNameWithEncoding: String = secondCityName.encodeString()
    // Weather api url params
    static let units: String = "metric"
    static let lang: String = "fr"
    static let format: String = "text"
    
    //first city Weather api url
    let firstCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(firstCityNameWithEncoding)&units=\(units)&lang=\(lang)&appid=\(openWeatherApi)")!
    //second city Weather api url
    let secondCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(secondCityNameWithEncoding)&units=\(units)&lang=\(lang)&appid=\(openWeatherApi)")!
    
    //Unique task
    private var task: URLSessionDataTask?
    
    
    //======================
    // MARK: - Get city Name
    //======================
    
    /// Get first city name
    /// - Parameter callback: Bool and Name
    func getFirstCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: firstCityUrl, callback: callback)
    }
    
    /// Get second city name
    /// - Parameter callback: Bool and Name
    func getSecondCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: secondCityUrl, callback: callback)
    }
    
    /// Get city name rates API Call
    /// - Parameters:
    ///   - url: first city or second city api url
    ///   - callback: Bool and Name
    private func getCityName(url: URL, callback: @escaping (Bool, Name?) -> Void ) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                self.createNameObjectToSend(with: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    /// Create name object to send in callback
    /// - Parameters:
    ///   - data: API data name
    ///   - callback: Bool and Name
    private func createNameObjectToSend(with data: Data, callback: @escaping (Bool, Name?) -> Void  ) {
        let name = try? JSONDecoder().decode(Name.self, from: data)
        if let name = name?.name {
            let name = Name(name: name)
            callback(true,name)
        }
    }
    
    //======================
    // MARK: - Get city temperature
    //======================
    
    /// Get first city temperature
    /// - Parameter callback: Bool and Main
    func getFirstCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: firstCityUrl, callback: callback)
        
    }
    /// Get second city temperature
    /// - Parameter callback: Bool and Main
    func getSecondCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: secondCityUrl, callback: callback)
    }
    
    /// Get temperature API Call
    /// - Parameters:
    ///   - url: first city or second city api url
    ///   - callback: Bool and Main
    private func getTemperature(url: URL, callback: @escaping (Bool, Main?) -> Void ) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                self.createMainObjectToSend(with: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    /// Create temperature object to send in callback
    /// - Parameters:
    ///   - data: API data temp
    ///   - callback: Bool and Main
    private func createMainObjectToSend(with data: Data, callback: @escaping (Bool, Main?) -> Void  ) {
        let temperature = try? JSONDecoder().decode(WeatherData.self, from: data)
        if let temperature = temperature?.main.temp {
            let temperature = Main(temp: temperature)
            callback(true, temperature)
        }
    }
    
    //======================
    // MARK: - Get city weather description
    //======================
    
    /// Get first city weather description
    /// - Parameter callback: Bool and Weather
    func getFirstCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: firstCityUrl, callback: callback)
    }
    
    /// Get second city weather description
    /// - Parameter callback: Bool and Weather
    func getSecondCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: secondCityUrl, callback: callback)
    }
    
    /// Get weather description API Call
    /// - Parameters:
    ///   - url: first city or second city api url
    ///   - callback: Bool and Weather
    private func getWeatherDescription(url: URL, callback: @escaping (Bool, Weather?) -> Void ) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                self.createWeatherObjectToSend(with: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    /// Create weather description object to send in callback
    /// - Parameters:
    ///   - data: API data description
    ///   - callback: Bool and Weather
    private func createWeatherObjectToSend(with data: Data, callback: @escaping (Bool, Weather?) -> Void  ) {
        let weather = try? JSONDecoder().decode(WeatherData.self, from: data)
        if let weather  = weather?.weather {
            for i in weather  {
                if let description = i.description{
                    let description = description
                    let weatherDescription = Weather(description: description, icon: nil)
                    callback(true, weatherDescription)
                }
            }
        }
    }
    
    //======================
    // MARK: - Get city weather Icon
    //======================
    
    /// Get first city weather icon
    /// - Parameter callback: Bool and Data
    func getFirstCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: firstCityUrl, callback: callback)
    }
    
    /// Get second city weather icon
    /// - Parameter callback: Bool and Data
    func getSecondCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: secondCityUrl, callback: callback)
    }
    
    /// Get icon API Call
    /// - Parameters:
    ///   - url: first city or second city api url
    ///   - callback: Bool and Data
    private func getIcon(url: URL, callback: @escaping (Bool, Data?) -> Void ) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                self.createIconObjectToSend(with: data, callback: callback)
            }
        }
        task?.resume()
    }
    
    /// Create icon object to send in callback
    /// - Parameters:
    ///   - data: API data icon
    ///   - callback: Bool and Data
    private func createIconObjectToSend(with data: Data, callback: @escaping (Bool, Data?) -> Void  ) {
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
        if let weatherData = weatherData?.weather {
            for i in weatherData {
                if let icon = i.icon {
                    let icon = icon
                    URLSession.shared.dataTask(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!) { iconData, _ , _ in
                        if let iconData = iconData {
                            DispatchQueue.main.async {
                                let icon = iconData
                                callback(true, icon)
                            }
                        }
                    }.resume()
                }
            }
        }
    }
    
    
}

