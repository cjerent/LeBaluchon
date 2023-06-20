//
//  Double+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 12/06/2023.
//

import Foundation


extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
    
    var roundedString:String {
        return String(format: "%.4f", self)
    }
}

