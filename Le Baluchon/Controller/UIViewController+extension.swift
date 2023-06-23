//
//  UIViewController+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 23/06/2023.
//

import UIKit

extension UIViewController {
    
    func showActivityIndicator(hide button: UIButton, show activityIndicator: UIActivityIndicatorView) {
        button.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func hideActivityIndicator(hide activityIndicator: UIActivityIndicatorView, show button: UIButton) {
        button.isHidden = false
        activityIndicator.isHidden = true
    }
    
    func showActivityIndicatorWithoutButton(of activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = false
    }
    
    func hideActivityIndicatorWithoutButton(of activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = true
    }
    
}
