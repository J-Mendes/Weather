//
//  Condition.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import Foundation

struct Condition {

    fileprivate let ImageUrlTemplate: String = "http://l.yimg.com/a/i/us/we/52/%@.gif"
    
    internal var code: String!
    internal var temperature: String!
    internal var text: String!
    
    internal var imageUrl: String {
        return code != nil && !code.isEmpty ? String(format: self.ImageUrlTemplate, self.code) : ""
    }
    
    init() {
        self.code = ""
        self.temperature = ""
        self.text = ""
    }
    
    init(dictionary: [String: Any]) {
        self.init()
        
        if let code: String = dictionary["code"] as? String {
            self.code = code
        }
        
        if let temperature: String = dictionary["temp"] as? String {
            self.temperature = temperature
        }
        
        if let text: String = dictionary["text"] as? String {
            self.text = text
        }
    }
    
}
