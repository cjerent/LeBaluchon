//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/05/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    // IBOulet First City
    @IBOutlet weak var firstCityNameUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherTemperatureUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherDescriptionUILabel: UILabel!
    @IBOutlet weak var firstCityWeatherIconUIImageView: UIImageView!
    // IBOulet Second City
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
        showActivityIndicatorWithoutButton(of: firstCityIconActivityIndicatorView)
        showActivityIndicatorWithoutButton(of: secondCityIconActivityIndicatorView)
        displayFullWeatherInfo()
    }
    
    private func displayFullWeatherInfo() {
        changeNameDisplay()
        changetemperatureDisplay()
        changeDescriptionDisplay()
        changeIconDisplay()
    }
    
    
    private func changeIconDisplay() {
        WeatherService.shared.getFirstCityWeatherIcon { (success, icon ) in
            self.updateIcon(self.firstCityWeatherIconUIImageView, with: success, and: icon, activityIndicator: self.firstCityIconActivityIndicatorView)
        }
        WeatherService.shared.getSecondCityWeatherIcon { (success, icon ) in
            self.updateIcon(self.secondCityWeatherIconUIImageView, with: success, and: icon, activityIndicator: self.secondCityIconActivityIndicatorView)
        }
    }
    
    private func changeNameDisplay() {
        WeatherService.shared.getFirstCityName{ (success, cityName ) in
            self.updateName(self.firstCityNameUILabel, with: success, and: cityName)
        }
        
        WeatherService.shared.getSecondCityName { (success, cityName ) in
            self.updateName(self.secondCityNameUILabel, with: success, and: cityName)
        }
    }
    
    private func changetemperatureDisplay() {
        
        WeatherService.shared.getFirstCityTemperature {(success, temperature) in
            self.updateTemperature(self.firstCityWeatherTemperatureUILabel, with: success, and: temperature)
        }
        
        WeatherService.shared.getSecondCityTemperature { (success, temperature) in
            self.updateTemperature(self.secondCityWeatherTemperatureUILabel, with: success, and: temperature)
        }
    }
    
    private func changeDescriptionDisplay() {
        WeatherService.shared.getFirstCityWeatherDescription { (success, description) in
            self.updateDescription(self.firstCityWeatherDescriptionUILabel, with: success, and: description)
        }
        WeatherService.shared.getSecondCityWeatherDescription { (success, description) in
            self.updateDescription(self.secondCityWeatherDescriptionUILabel, with: success, and: description)
        }
    }
    
    private func displayIcon(of imageView : UIImageView, with icon: Data) {
        imageView.image = UIImage(data: icon)
    }
    
    private func displayName(of label: UILabel, with cityName: Name) {
        label.text = cityName.name?.capitalized
    }

    private func displayTemperature(of label: UILabel, with temperature: Main) {
        let temp: Double? = temperature.temp
        if let temp = temp {
            let cityTemp = temp.toString()
            label.text = "\(cityTemp)°"
        }
    }
    
    private func displayDescription(of label : UILabel, with description: Weather) {
        label.text = description.description?.capitalized
    }

    
    private func updateIcon(_ image: UIImageView, with success: Bool, and icon: Data?, activityIndicator: UIActivityIndicatorView) {
        guard let icon = icon, success == true else {
            self.showAlert(title: "Erreur", message: "Le téléchargement de l'image a écouché...Veuillez rééssayer 😥")
            return
        }
        displayIcon(of: image, with: icon)
        activityIndicator.isHidden = true
    }
    
    private func updateName(_ label: UILabel, with success: Bool, and cityName: Name?) {
        guard let cityName = cityName, success == true else {
            self.showAlert(title: "Erreur", message: "Le téléchargement du nom de la ville a écouché...Veuillez rééssayer 😥")
            return
        }
        displayName(of: label, with: cityName)
    }
    
    private func updateTemperature(_ label: UILabel, with success: Bool, and temperature: Main?) {
        guard let temperature = temperature, success == true else {
            self.showAlert(title: "Erreur", message: "Le téléchargement de la température a écouché...Veuillez rééssayer 😥")
            return
        }
        displayTemperature(of: label, with: temperature)
    }
    
    private func updateDescription(_ label: UILabel, with success: Bool, and description: Weather?) {
        guard let description = description, success == true else {
            self.showAlert(title: "Erreur", message: "Le téléchargement de la description a écouché...Veuillez rééssayer 😥")
            return
        }
        displayDescription(of: label, with: description)
    }
    
    private func modifyStackViewStyle(of stackView: UIStackView) {
        stackView.layer.cornerRadius = 5.0
    }
    
}


