//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    // IBOulets First City
    @IBOutlet weak var firstCityNameUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherTemperatureUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherDescriptionUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherIconUIImageView: UIImageView!
    // IBOulets Second City
    @IBOutlet weak var secondCityNameUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherTemperatureUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherDescriptionUILabel: UILabel!
    @IBOutlet weak var secondCityWeatherIconUIImageView: UIImageView!
    // IBOulet Presentation text
    @IBOutlet weak var presentationUIStackView: UIStackView!
    //ActivityIndicator for ICON
    @IBOutlet weak var firstCityIconActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var secondCityIconActivityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyStackViewStyle(of: presentationUIStackView)
        showBothIconsActivityIndicator()
        displayFullWeatherInfo()
        
    }
    
    /// Display weather info
    private func displayFullWeatherInfo() {
        displayBothIcons()
        displayBothNames()
        displayBothTemperatures()
        displayBothDescription()
        
    }
    
    //======================
    // MARK: - ICON DISPLAY
    //======================
    
    
    /// Receive icon from WeatherService
    /// - Parameters:
    ///   - image: UIImageView
    ///   - success: Bool
    ///   - icon: Data from Weather Service
    ///   - activityIndicator: UIActivityIndicatorView
    private func updateIcon(_ image: UIImageView, with success: Bool, and icon: Data?, activityIndicator: UIActivityIndicatorView) {
        guard let icon = icon, success == true else {
            self.showAlert(title: "❌", message: "Le téléchargement de l'image a écouché...Veuillez rééssayer 😥")
            return
        }
        displayIcon(in: image, with: icon)
        activityIndicator.isHidden = true
    }
    
    /// Display icon in UIImageView
    /// - Parameters:
    ///   - imageView: UIImageView
    ///   - icon: icon from WeatherService
    private func displayIcon(in imageView : UIImageView, with icon: Data) {
        imageView.image = UIImage(data: icon)
    }
    
    /// Display icons of both cities in firstCityWeatherIconUIImageView and secondCityWeatherIconUIImageView
    private func displayBothIcons() {
        WeatherService.shared.getFirstCityWeatherIcon { (success, icon ) in
            self.updateIcon(self.firstCityWeatherIconUIImageView, with: success, and: icon, activityIndicator: self.firstCityIconActivityIndicatorView)
        }
        WeatherService.shared.getSecondCityWeatherIcon { (success, icon ) in
            self.updateIcon(self.secondCityWeatherIconUIImageView, with: success, and: icon, activityIndicator: self.secondCityIconActivityIndicatorView)
        }
    }
    
    /// Show activity indicator for firstCityIconActivityIndicatorView and secondCityIconActivityIndicatorView
    private func showBothIconsActivityIndicator() {
        showActivityIndicatorWithoutButton(of: firstCityIconActivityIndicatorView)
        showActivityIndicatorWithoutButton(of: secondCityIconActivityIndicatorView)
    }
    
    //======================
    // MARK: - NAME DISPLAY
    //======================
    
    
    /// Receive name from WeatherService
    /// - Parameters:
    ///   - label: UILabel
    ///   - success: Bool
    ///   - cityName: Name of WeatherService
    private func updateName(_ label: UILabel, with success: Bool, and cityName: Name?) {
        guard let cityName = cityName, success == true else {
            self.showAlert(title: "❌", message: "Le téléchargement du nom de la ville a écouché...Veuillez rééssayer 😥")
            return
        }
        displayName(in: label, with: cityName)
    }
    
    /// Display name in UILabel
    /// - Parameters:
    ///   - label: UILabel
    ///   - cityName: name from WeatherServic
    private func displayName(in label: UILabel, with cityName: Name) {
        label.text = cityName.name?.capitalized
    }
    
    /// Display names of both cities in firstCityNameUILabel and secondCityNameUILabel
    private func displayBothNames() {
        WeatherService.shared.getFirstCityName{ (success, cityName ) in
            self.updateName(self.firstCityNameUILabel, with: success, and: cityName)
        }
        WeatherService.shared.getSecondCityName { (success, cityName ) in
            self.updateName(self.secondCityNameUILabel, with: success, and: cityName)
        }
    }
    
    //======================
    // MARK: - TEMPERATURE DISPLAY
    //======================
    
    /// Receive temperature from WeatherService
    /// - Parameters:
    ///   - label: UILabel
    ///   - success: Bool
    ///   - temperature: Main from WeatherService
    private func updateTemperature(_ label: UILabel, with success: Bool, and temperature: Main?) {
        guard let temperature = temperature, success == true else {
            self.showAlert(title: "❌", message: "Le téléchargement de la température a écouché...Veuillez rééssayer 😥")
            return
        }
        displayTemperature(in: label, with: temperature)
    }
    
    /// Display temperature in UILabel
    /// - Parameters:
    ///   - label: UILabel
    ///   - temperature: temp from WeatherService
    private func displayTemperature(in label: UILabel, with temperature: Main) {
        let temp: Double? = temperature.temp
        if let temp = temp {
            let cityTemp = temp.toString()
            label.text = "\(cityTemp)°"
        }
    }
    
    /// Display temperatures of both cities in firstCityWeatherTemperatureUILabel and secondCityWeatherTemperatureUILabel
    private func displayBothTemperatures() {
        WeatherService.shared.getFirstCityTemperature {(success, temperature) in
            self.updateTemperature(self.firstCityWeatherTemperatureUILabel, with: success, and: temperature)
        }
        WeatherService.shared.getSecondCityTemperature { (success, temperature) in
            self.updateTemperature(self.secondCityWeatherTemperatureUILabel, with: success, and: temperature)
        }
    }
    
    //======================
    // MARK: - DESCRIPTION DISPLAY
    //======================
    
    /// Receive description from WeatherService
    /// - Parameters:
    ///   - label: UILabel
    ///   - success: Bool
    ///   - description: Weather from WeatherService
    private func updateDescription(_ label: UILabel, with success: Bool, and description: Weather?) {
        guard let description = description, success == true else {
            self.showAlert(title: "❌", message: "Le téléchargement de la description a écouché...Veuillez rééssayer 😥")
            return
        }
        displayDescription(in: label, with: description)
    }
    
    /// Display description in UILabel
    /// - Parameters:
    ///   - label: UILabel
    ///   - description: description from WeatherService
    private func displayDescription(in label : UILabel, with description: Weather) {
        label.text = description.description?.capitalized
    }
    
    /// Display weather description of both cities in firstCityWeatherDescriptionUILabel and secondCityWeatherDescriptionUILabel
    private func displayBothDescription() {
        WeatherService.shared.getFirstCityWeatherDescription { (success, description) in
            self.updateDescription(self.firstCityWeatherDescriptionUILabel, with: success, and: description)
        }
        WeatherService.shared.getSecondCityWeatherDescription { (success, description) in
            self.updateDescription(self.secondCityWeatherDescriptionUILabel, with: success, and: description)
        }
    }
    
    
    /// Custom UIStackView style
    /// - Parameter stackView: UIStackView
    private func modifyStackViewStyle(of stackView: UIStackView) {
        stackView.layer.cornerRadius = 5.0
    }
    
}


