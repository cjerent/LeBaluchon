//
//  String+extension.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 14/06/2023.
//

import Foundation

extension String {
    func encodeString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
