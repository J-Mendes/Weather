//
//  Astronomy.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Astronomy {

    internal var sunrise: Date!
    internal var sunset: Date!
    
    init() {
        self.sunrise = Date()
        self.sunset = Date()
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let sunriseString: String = dictionary["sunrise"] as? String,
            let sunrise: Date = sunriseString.dateValueFromHour() {
            self.sunrise = sunrise
        }
        
        if let sunsetString: String = dictionary["sunset"] as? String,
            let sunset: Date = sunsetString.dateValueFromHour() {
            self.sunset = sunset
        }
    }
    
}
