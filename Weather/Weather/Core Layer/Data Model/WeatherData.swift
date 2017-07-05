//
//  WeatherData.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct WeatherData {

    internal var units: Units!
    internal var city: String!
    internal var country: String!
    internal var lastUpdateDate: String!
    internal var wind: Wind!
    internal var atmosphere: Atmosphere!
    internal var astronomy: Astronomy!
    internal var weather: Weather!
    
    init() {
        self.units = Units()
        self.city = ""
        self.country = ""
        self.lastUpdateDate = ""
        self.wind = Wind()
        self.atmosphere = Atmosphere()
        self.astronomy = Astronomy()
        self.weather = Weather()
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let units: [String: Any] = dictionary["units"] as? [String: Any] {
            self.units = Units(dictionary: units)
        }
        
        if let location: [String: Any] = dictionary["location"] as? [String: Any] {
            if let city: String = location["city"] as? String {
                self.city = city
            }
            
            if let country: String = location["country"] as? String {
                self.country = country
            }
        }
        
        if let lastUpdateDate: String = dictionary["lastBuildDate"] as? String {
            self.lastUpdateDate = lastUpdateDate
        }
        
        if let wind: [String: Any] = dictionary["wind"] as? [String: Any] {
            self.wind = Wind(dictionary: wind)
        }
        
        if let atmosphere: [String: Any] = dictionary["atmosphere"] as? [String: Any] {
            self.atmosphere = Atmosphere(dictionary: atmosphere)
        }
        
        if let astronomy: [String: Any] = dictionary["astronomy"] as? [String: Any] {
            self.astronomy = Astronomy(dictionary: astronomy)
        }
        
        if let weather: [String: Any] = dictionary["item"] as? [String: Any] {
            self.weather = Weather(dictionary: weather)
        }
    }
    
}
