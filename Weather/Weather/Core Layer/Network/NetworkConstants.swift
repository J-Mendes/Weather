//
//  NetworkConstants.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

class NetworkConstants {

    static let baseUrl: String = "https://query.yahooapis.com/v1/public/yql"
    
    struct Url {
        static let weatherForecast: String = "\(NetworkConstants.baseUrl)?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"%@\")%@&format=json&env=store://datatables.org/alltableswithkeys"
        static let weatherUnitsModifier: String = " and u='c'"
        
        static let place: String = "\(NetworkConstants.baseUrl)?q=select admin1.content, admin2.content, country.code from geo.places where text=\"(%f,%f)\" limit 1&diagnostics=false&format=json"
    }
    
}
