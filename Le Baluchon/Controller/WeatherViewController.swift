//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var firstCityNameUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherTemperatureUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherDescriptionUILabel: UILabel!
 
    
    var weather = WeatherService()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        changeDisplay()

   }
    
    func changeDisplay() {
//        weather.getWeatherDescription { (success, description), (success, temperature) in
//            guard let description = description, let temperature = temperature, success == true else {
//                self.presentAlert(message: "The description failed")
//                return
//            }
//
//
//            self.updateDescription(description, temperature)
        
        weather.getWeatherDescription { (success, description) in
            guard let description = description, success == true else {
                self.presentAlert(message: "The description failed")
                               return
            }
            
        } callback2:{ (success, temperature) in
            guard let temperature = temperature, success == true else {
                self.presentAlert(message: "The temp failed")
                               return
            }

//            updateDescription(description, temperature)
        }
    
    
        
        weather.getCityName { (success, cityName ) in
            guard let cityName = cityName, success == true else {
                self.presentAlert(message: "The city name failed")
                return
            }
            self.updateName(cityName)
        }

//        weather.getCityTemperature { (success, cityTemperature ) in
//            guard let cityTemperature = cityTemperature, success == true else {
//                self.presentAlert()
//                return
//            }
//            self.updateTemperature(cityTemperature)
//        }
    
    }
    
    private func updateDescription(_ description: Weather, _ temperature: Main) {
        firstCityWeatherDescriptionUILabel.text = "\(String(describing: description.description?.capitalized))"
        firstCityWeatherTemperatureUILabel.text = "\(String(describing: temperature.temp))"

    }
    private func updateName(_ name: Name) {
            firstCityNameUILabel.text = name.name?.capitalized
        
        }
    
//    private func updateTemperature(_ temperature: Main) {
//        var temp = String(temperature)
//        firstCityWeatherTemperatureUILabel.text = temp.temp
//        }
    
    private func presentAlert(message: String) {
          let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
       present(alertVC, animated: true, completion: nil)
    }
}
