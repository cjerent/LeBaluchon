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
    @IBOutlet weak var firstCityWeatherIconUIImageView: UIImageView!
    
    @IBOutlet weak var secondCityNameUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherTemperatureUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherDescriptionUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherIconUIImageView: UIImageView!
    
    @IBOutlet weak var presentationUIStackView: UIStackView!
    var weather = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyStackViewStyle(of: presentationUIStackView)
        changeNameDisplay()
        changetemperatureDisplay()
        changeDescriptionDisplay()
        changeIconDisplay()
        
    }
    
    func changeDescriptionDisplay() {
        weather.getFirstCityWeatherDescription { (success, description) in
            guard let description = description, success == true else {
                self.presentAlert(message: "Description download failed")
                return
            }
            self.updateDescription(description, of: self.firstCityWeatherDescriptionUILabel)
        }
        weather.getSecondCityWeatherDescription { (success, description) in
            guard let description = description, success == true else {
                self.presentAlert(message: "Description download failed")
                return
            }
            self.updateDescription(description, of: self.secondCityWeatherDescriptionUILabel)
        }
    }
    
    func changeIconDisplay() {
        weather.getFirstCityWeatherIcon { (success, icon ) in
            guard let icon = icon, success == true else {
                self.presentAlert(message: "Image download failed")
                return
            }
            self.updateIcon(icon, of: self.firstCityWeatherIconUIImageView)
        }
        weather.getSecondCityWeatherIcon { (success, icon ) in
            guard let icon = icon, success == true else {
                self.presentAlert(message: "Image download failed")
                return
            }
            self.updateIcon(icon, of: self.secondCityWeatherIconUIImageView)
        }
    }
    
    func changeNameDisplay() {
        weather.getFirstCityName{ (success, cityName ) in
            guard let cityName = cityName, success == true else {
                self.presentAlert(message: "City name download failed")
                return
            }
            self.updateName(cityName, of: self.firstCityNameUILabel)
        }
        weather.getSecondCityName { (success, cityName ) in
            guard let cityName = cityName, success == true else {
                self.presentAlert(message: "City name download failed")
                return
            }
            self.updateName(cityName,of: self.secondCityNameUILabel )
        }
    }
    
    func changetemperatureDisplay() {
        weather.getFirstCityTemperature { (success, temperature) in
            guard let temperature = temperature, success == true else {
                self.presentAlert(message: "Temperature download failed")
                return
            }
            self.updateTemperature(temperature, of: self.firstCityWeatherTemperatureUILabel)
        }
        weather.getSecondCityTemperature { (success, temperature) in
            guard let temperature = temperature, success == true else {
                self.presentAlert(message: "Temperature download failed")
                return
            }
            self.updateTemperature(temperature, of: self.secondCityWeatherTemperatureUILabel)
        }
    }
    
    private func updateDescription(_ description: Weather, of label : UILabel) {
        label.text = description.description?.capitalized
    }
    private func updateName(_ name: Name, of label: UILabel) {
        label.text = name.name?.capitalized
    }
    
    private func updateIcon(_ icon: Data, of imageView : UIImageView) {
        imageView.image = UIImage(data: icon)
    }
    
    private func updateTemperature(_ temperature: Main, of label: UILabel) {
        let temp: Double? = temperature.temp
        if let temp = temp {
            let cityTemp = temp.toString()
            label.text = "\(cityTemp)°"
        }
    }
    
   func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func modifyStackViewStyle(of stackView: UIStackView) {
         stackView.layer.cornerRadius = 5.0
    }
    
}






