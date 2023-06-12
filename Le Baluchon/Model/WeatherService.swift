//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 07/06/2023.
//

import Foundation

var openWeatherApi = valueForAPIKey(named: "openWeatherBaluchApi")

class WeatherService {
   
    var firstCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.7127281&lon=-74.0060152&units=metric&lang=fr&appid=\(openWeatherApi)")!
    var secondCityUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&lang=fr&appid=\(openWeatherApi)")!

    private var task: URLSessionDataTask?
    
    
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
                
                let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
                
                if let weatherData = weatherData?.weather {
                    
                    for i in weatherData {
                        if let description = i.description{
                            let description = description
                            
                            
                            
                            print(i.description!)
                            
                            let additionnalWeatherInfo = Weather(description: description, icon: nil)
                            callback(true, additionnalWeatherInfo)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        if let task = task {
            task.resume()
        }
        
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
                
                
                let main = try? JSONDecoder().decode(WeatherData.self, from: data)
                
                if let main = main?.main.temp {
                    
                    print(main)
                    let citytemp = Main(temp: main)
                    callback(true,citytemp)
                    
                    
                }
            }
        }
        if let task = task {
            task.resume()
        }
        
        
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
                
                let cityName = try? JSONDecoder().decode(Name.self, from: data)
                
                if let cityName = cityName?.name {
                    print(cityName)
                    print(cityName) 
                    let name = Name(name: cityName)
                    callback(true,name)
                    
                }
            }
        }
        if let task = task {
            task.resume()
        }
        
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
                
                let weatherData2 = try? JSONDecoder().decode(WeatherData.self, from: data)
                
                if let weatherData2 = weatherData2?.weather {
                    
                    for i in weatherData2 {
                        if let icon = i.icon {
                            let icon = icon
                            print(icon)
                            URLSession.shared.dataTask(with: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!) { iconData, _ , _ in
                                if let iconData = iconData {
                                    DispatchQueue.main.async {
                                        callback(true, iconData)
                                    }
                                }
                            }.resume()
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        if let task = task {
            task.resume()
        }
    }
    
    func getFirstCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityWeatherDescription(callback: @escaping (Bool, Weather?) -> Void ) {
        getWeatherDescription(url: secondCityUrl, callback: callback)
    }
    
    
    
    func getFirstCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityWeatherIcon(callback: @escaping (Bool, Data?) -> Void ) {
        getIcon(url: secondCityUrl, callback: callback)
    }
    
    
    
    
    func getFirstCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: firstCityUrl, callback: callback)
    }
    
    func getSecondCityName(callback: @escaping (Bool, Name?) -> Void) {
        getCityName(url: secondCityUrl, callback: callback)
    }
    
    
    
    func getFirstCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: firstCityUrl, callback: callback)
        
    }
    func getSecondCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
        getTemperature(url: secondCityUrl, callback: callback)
    }
    
}

