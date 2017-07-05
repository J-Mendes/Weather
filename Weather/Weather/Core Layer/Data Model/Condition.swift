//
//  Condition.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Condition {

    internal var code: String!
    internal var date: String!
    internal var temperature: String!
    internal var text: String!
    
    init() {
        self.code = ""
        self.date = ""
        self.temperature = ""
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
        
        if let temperature: String = dictionary["temp"] as? String {
            self.temperature = temperature
        }
        
        if let text: String = dictionary["text"] as? String {
            self.text = text
        }
    }
    
}
