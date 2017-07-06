//
//  Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Weather {

    internal var condition: Condition!
    internal var forecast: [Forecast]!
    
    internal var todayForecast: Forecast? {
        let todayForecast: [Forecast] = self.forecast.filter { $0.date.isToday() }
        return todayForecast.count > 0 ? todayForecast.first! : nil
    }
    
    internal var forecastPrevisions: [Forecast] {
        return self.forecast.filter { $0.date > Date() }
    }
    
    init() {
        self.condition = Condition()
        self.forecast = []
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let condition: [String: Any] = dictionary["condition"] as? [String: Any] {
            self.condition = Condition(dictionary: condition)
        }
        
        if let forecasts: [[String: Any]] = dictionary["forecast"] as? [[String: Any]] {
            forecasts.forEach {
                self.forecast.append(Forecast(dictionary: $0))
            }
            self.forecast.sort { $0.0.date < $0.1.date }
        }
    }
    
}
