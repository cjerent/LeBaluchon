//
//  Alert.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 20/06/2023.
//

import Foundation

import Foundation
import UIKit

extension UIViewController {
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
}
