//
//  UIViewController+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/06/2023.
//
import Foundation
import UIKit

extension UIViewController {
    
    /// Show error/Info alert
    /// - Parameters:
    ///   - title: String
    ///   - message: String
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
    
    /// Show activity Indicator and hide button
    /// - Parameters:
    ///   - button: UIButton
    ///   - activityIndicator: UIActivityIndicatorView
    func showActivityIndicator(hide button: UIButton, show activityIndicator: UIActivityIndicatorView) {
        button.isHidden = true
        activityIndicator.isHidden = false
    }
    
    /// Hide activity Indicator and show button
    /// - Parameters:
    ///   - activityIndicator: UIActivityIndicatorView,
    ///   - button: UIButton
    func hideActivityIndicator(hide activityIndicator: UIActivityIndicatorView, show button: UIButton) {
        button.isHidden = false
        activityIndicator.isHidden = true
    }
    
    /// Show activity Indicator
    /// - Parameter activityIndicator: UIActivityIndicatorView
    func showActivityIndicatorWithoutButton(of activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = false
    }
    
    /// Hide activity Indicator
    /// - Parameter activityIndicator: UIActivityIndicatorView
    func hideActivityIndicatorWithoutButton(of activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = true
    }
    
}
