//
//  Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Weather {

    internal var latitude: Double!
    internal var longitude: Double!
    internal var publishDate: String!
    internal var condition: Condition!
    internal var forecast: [Forecast]!
    
    init() {
        self.latitude = 0.0
        self.longitude = 0.0
        self.publishDate = ""
        self.condition = Condition()
        self.forecast = []
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let latString: String = dictionary["lat"] as? String,
            let latitude: Double = Double(latString)  {
            self.latitude = latitude
        }
        
        if let lonString: String = dictionary["long"] as? String,
            let longitude: Double = Double(lonString)  {
            self.longitude = longitude
        }
        
        if let publishDate: String = dictionary["pubDate"] as? String {
            self.publishDate = publishDate
        }
        
        if let condition: [String: Any] = dictionary["condition"] as? [String: Any] {
            self.condition = Condition(dictionary: condition)
        }
        
        if let forecasts: [[String: Any]] = dictionary["forecast"] as? [[String: Any]] {
            forecasts.forEach {
                self.forecast.append(Forecast(dictionary: $0))
            }
        }
    }
    
}
