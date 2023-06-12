//
//  WeatherInfo.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 07/06/2023.
//

import Foundation


struct Name: Decodable {
    let name: String?
}

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let description: String?
    let icon: String?
}

struct Main: Decodable {
    let temp: Double?
}
