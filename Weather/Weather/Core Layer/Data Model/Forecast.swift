//
//  Forecast.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Forecast {

    fileprivate let ImageUrlTemplate: String = "http://l.yimg.com/a/i/us/we/52/%@.gif"
    
    internal var code: String!
    internal var date: Date!
    internal var high: String!
    internal var low: String!
    internal var text: String!
    
    internal var imageUrl: String {
        return code != nil && !code.isEmpty ? String(format: self.ImageUrlTemplate, self.code) : ""
    }
    
    init() {
        self.code = ""
        self.date = Date()
        self.high = ""
        self.low = ""
        self.text = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let code: String = dictionary["code"] as? String {
            self.code = code
        }
        
        if let dateString: String = dictionary["date"] as? String,
            let date: Date = dateString.dateValueFromShortDate() {
            self.date = date
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
