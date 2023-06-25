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
        return String(format: "%.2f", self)
    }
}




