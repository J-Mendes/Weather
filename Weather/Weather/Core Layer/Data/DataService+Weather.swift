//
//  DataService+Weather.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

extension DataService {

    // MARK: Weather Data
    
    internal func getWeather(place: String, units: Int, completion: @escaping (WeatherData?, Error?) -> Void) {
        self.networkService.getWeather(place: place, units: units) { (data: [String : Any]?, error: Error?) in
            if error == nil {
                if data != nil,
                    let query: [String: Any] = data!["query"] as? [String: Any],
                    let results: [String: Any] = query["results"] as? [String: Any],
                    let channel: [String: Any] = results["channel"] as? [String: Any] {
                    
                    let weatherData: WeatherData = WeatherData(dictionary: channel)
                    DispatchQueue.main.async {
                        completion(weatherData, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
}
