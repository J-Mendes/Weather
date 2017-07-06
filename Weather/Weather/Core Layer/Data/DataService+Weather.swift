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
    
    internal func getWeather(place: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        self.networkService.getWeather(place: place) { (data: [String : Any]?, error: Error?) in
            if error == nil {
                if data != nil,
                    let query: [String: Any] = data!["query"] as? [String: Any],
                    let results: [String: Any] = query["results"] as? [String: Any],
                    let channel: [String: Any] = results["channel"] as? [String: Any] {
                    
                    let weatherData: WeatherData = WeatherData(dictionary: channel)
                    completion(weatherData, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
}
