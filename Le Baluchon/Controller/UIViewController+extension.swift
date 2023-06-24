//
//  UIViewController+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/06/2023.
//

import UIKit

extension UIViewController {
    
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
