//
//  Double+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 12/06/2023.
//

import Foundation


extension Double {
    /// transform Double to String with one figure after the decimal point
    /// - Returns: String
    func toString() -> String {
        return String(format: "%.1f",self)
    }
    //transform Double to String with four figure after the decimal point
    var roundedString:String {
        return String(format: "%.4f", self)
    }
}

//extension String {
//    static let numberFormatter = NumberFormatter()
//    var doubleValue: Double {
//        String.numberFormatter.decimalSeparator = "."
//        if let result =  String.numberFormatter.number(from: self) {
//            return result.doubleValue
//        } else {
//            String.numberFormatter.decimalSeparator = ","
//            if let result = String.numberFormatter.number(from: self) {
//                return result.doubleValue
//            }
//        }
//        return 0
//    }
}

