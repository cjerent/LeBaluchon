//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 07/06/2023.
//

import Foundation



class WeatherService {
    var firstCityWeatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.7127281&lon=-74.0060152&units=metric&lang=fr&appid=6607b53f012f831b1e470e12f4593f43")!
    var SecondCityWeatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&lang=fr&appid=6607b53f012f831b1e470e12f4593f43")!
    private var task: URLSessionDataTask?
    
    
    
    
// fonction pour recup la description NE FONCTIONNE PAS. J'ai mis 3 arg au callback pour tester mais ce n'est pas l'ideal car impossible a afficher dan sle VC;
    
    func getWeatherDescription(callback1: @escaping (Bool, Weather?) -> Void, callback2: @escaping (Bool, Main?) -> Void ) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: firstCityWeatherUrl) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback1(false, nil)
                    callback2(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback1(false, nil)
                    callback2(false, nil)
                    return
                }
                
                let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
                
                if let temperature = weatherData?.main.temp {
                    let temperature = temperature
                    print(temperature)
                    let tempInfo = Main(temp: temperature)
                    callback2(true,tempInfo)
                }
                
                if let weatherData = weatherData?.weather {
                    for i in weatherData {
                        if let description = i.description {
                            let description = description
                            print(i.description!)
                            let additionnalWeatherInfo = Weather(description: description)
                            callback1(true, additionnalWeatherInfo)
                        }
                       
                    }
                }
                
            }
       
        }
        if let task = task {
            task.resume()
        }
      
        
    }
    
// Fonction pour le nom de la ville FONCTIONNE
    func getCityName(callback: @escaping (Bool, Name?) -> Void) {
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: firstCityWeatherUrl) { data, response, error in
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
                    let name = Name(name: cityName)
                    callback(true,name)
                    
                }
                
            }
        }
        if let task = task {
            task.resume()
        }
    }
    
//Fonction pour la temperature NE FONCTIONNE PAS
//    func getCityTemperature(callback: @escaping (Bool, Main?) -> Void) {
//        let session = URLSession(configuration: .default)
//        task = session.dataTask(with: firstCityWeatherUrl) { data, response, error in
//            DispatchQueue.main.async {
//                guard let data = data, error == nil else {
//                    callback(false,nil)
//                    return
//                }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    callback(false,nil)
//                    return
//                }
//
//                let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
//
//                if let weatherData = weatherData{
//                    if let temperature = weatherData.main.temp {
//                        let temperature = weatherData
//                        print(temperature)
////                        let temperatureInfo = Main(temp: weatherData)
////                        callback(true,temperatureInfo)
//                    }
//                }
//
//
//                }
//            }
//        if let task = task {
//            task.resume()
//        }
//        }
//
    }
    
    
    
    
    
    //    func getWeather(callback: @escaping (Bool, Weather?) -> Void) {
    //        let session = URLSession(configuration: .default)
    //        let task = session.dataTask(with: firstCityWeatherUrl) { data, response, error in
    //            DispatchQueue.main.async {
    //                guard let data = data, error == nil else {
    //                    return
    //                }
    //                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                    return
    //                }
    //
    //                let response = try? JSONDecoder().decode(WeatherData.self, from: JSONData)
    //
    //                if let response = response {
    //                    for i in response.weather {
    //                        let description = i.description
    //                        let icon = i.icon
    //                        print("description: \(i.description)")
    //                        print("icon: \(i.icon)")
    //                        let additionalInfo = Weather(description: description, icon: icon)
    //                    }
    //                    if let response = response.main.temp{
    //                        let temperature = response
    //                        print(temperature)
    //                        let temperatureInfo = Main(temp: temperature)
    //                    }
    //
    //                }
    //
    //
    //            }
    //
    //        }
    //        task.resume()
    //    }

