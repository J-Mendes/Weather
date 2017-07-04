//
//  Wind.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Wind {

    internal var chill: String!
    internal var direction: String!
    internal var speed: String!
    
    init() {
        self.chill = ""
        self.direction = ""
        self.speed = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let chill: String = dictionary["chill"] as? String {
            self.chill = chill
        }
        
        if let direction: String = dictionary["direction"] as? String {
            self.direction = direction
        }
        
        if let speed: String = dictionary["speed"] as? String {
            self.speed = speed
        }
    }
    
}
