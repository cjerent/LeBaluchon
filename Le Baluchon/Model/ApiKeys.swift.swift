//
//  ApiKeys.swift.swift
//  Le Baluchon
//
//  Created by Charlène JERENT-BELDINEAU on 12/06/2023.
//

import Foundation


func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
let plist = NSDictionary(contentsOfFile:filePath!)
let value = plist?.object(forKey: keyname) as! String
return value 
}
