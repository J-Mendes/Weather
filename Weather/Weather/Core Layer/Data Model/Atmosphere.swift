//
//  Atmosphere.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Atmosphere {

    internal var humidity: String!
    internal var pressure: String!
    internal var rising: String!
    internal var visibility: String!
    
    init() {
        self.humidity = ""
        self.pressure = ""
        self.rising = ""
        self.visibility = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let humidity: String = dictionary["humidity"] as? String {
            self.humidity = humidity
        }
        
        if let pressure: String = dictionary["pressure"] as? String {
            self.pressure = pressure
        }
        
        if let rising: String = dictionary["rising"] as? String {
            self.rising = rising
        }
        
        if let visibility: String = dictionary["visibility"] as? String {
            self.visibility = visibility
        }
    }
    
}
