//
//  Forecast.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Forecast {

    internal var code: String!
    internal var date: String!
    internal var day: String!
    internal var high: String!
    internal var low: String!
    internal var text: String!
    
    init() {
        self.code = ""
        self.date = ""
        self.day = ""
        self.high = ""
        self.low = ""
        self.text = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let code: String = dictionary["code"] as? String {
            self.code = code
        }
        
        if let date: String = dictionary["date"] as? String {
            self.date = date
        }
        
        if let day: String = dictionary["day"] as? String {
            self.day = day
        }
        
        if let high: String = dictionary["high"] as? String {
            self.high = high
        }
        
        if let low: String = dictionary["low"] as? String {
            self.low = low
        }
        
        if let text: String = dictionary["text"] as? String {
            self.text = text
        }
    }
    
}
