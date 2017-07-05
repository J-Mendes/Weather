//
//  Units.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Units {

    internal var distance: String!
    internal var pressure: String!
    internal var speed: String!
    internal var temperature: String!
    
    init() {
        self.distance = ""
        self.pressure = ""
        self.speed = ""
        self.temperature = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let distance: String = dictionary["distance"] as? String {
            self.distance = distance
        }
        
        if let pressure: String = dictionary["pressure"] as? String {
            self.pressure = pressure
        }
        
        if let speed: String = dictionary["speed"] as? String {
            self.speed = speed
        }
        
        if let temperature: String = dictionary["temperature"] as? String {
            self.temperature = temperature
        }
    }
    
}
