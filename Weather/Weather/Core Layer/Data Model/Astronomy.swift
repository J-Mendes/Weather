//
//  Astronomy.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Astronomy {

    internal var sunrise: String!
    internal var sunset: String!
    
    init() {
        self.sunrise = ""
        self.sunset = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let sunrise: String = dictionary["sunrise"] as? String {
            self.sunrise = sunrise
        }
        
        if let sunset: String = dictionary["sunset"] as? String {
            self.sunset = sunset
        }
    }
    
}
