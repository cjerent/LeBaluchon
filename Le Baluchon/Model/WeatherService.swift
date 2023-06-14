//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 07/06/2023.
//

import Foundation

let openWeatherApi = valueForAPIKey(named: "openWeatherBaluchApi")

class WeatherService {
    
    let firstCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.7127281&lon=-74.0060152&units=metric&lang=fr&appid=\(openWeatherApi)")!
    let secondCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&lang=fr&appid=\(openWeatherApi)")!
    
    private var task: URLSessionDataTask?
    
    
    //======================
    // MARK: - Get city Name
    //======================
    
    func getFirstCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: secondCityUrl, callback: callback)
    }
    
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
        if let task = task {
            task.resume()
        }
    }
    
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
    
    func getFirstCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: firstCityUrl, callback: callback)
        
    }
    func getSecondCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: secondCityUrl, callback: callback)
    }
    
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
        if let task = task {
            task.resume()
        }
    }
    
    private func createMainObjectToSend(with data: Data, callback: @escaping (Bool, Main?) -> Void  ) {
        let main = try? JSONDecoder().decode(WeatherData.self, from: data)
        
        if let main = main?.main.temp {
            let citytemp = Main(temp: main)
            callback(true,citytemp)
            
            
        }
    }
    
    //======================
    // MARK: - Get city weather description
    //======================
    
    func getFirstCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: secondCityUrl, callback: callback)
    }
    
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
        if let task = task {
            task.resume()
        }
        
    }
    
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
    
    func getFirstCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: secondCityUrl, callback: callback)
    }
    
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
        if let task = task {
            task.resume()
        }
    }
    
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

