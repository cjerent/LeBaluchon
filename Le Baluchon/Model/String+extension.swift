//
//  String+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 14/06/2023.
//

import Foundation

extension String {
    /// Add percentage for space in string in url
    /// - Returns: String
    func encodeString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

extension String {
    // format decimal with a comma or a point
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
