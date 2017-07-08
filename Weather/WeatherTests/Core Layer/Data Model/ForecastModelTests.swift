//
//  ForecastModelTests.swift
//  Weather
//
//  Created by Jorge Mendes on 08/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class ForecastModelTests: XCTestCase {
    
    fileprivate let ValidImageUrl: String = "http://l.yimg.com/a/i/us/we/52/3.gif"
    
    fileprivate var forecast: Forecast!
    
    override func setUp() {
        super.setUp()
        
        self.forecast = Forecast()
    }
    
    override func tearDown() {
        self.forecast = nil
        
        super.tearDown()
    }
    
    func testValidImageUrl() {
        self.forecast.code = "3"
        
        XCTAssertEqual(self.forecast.imageUrl, ValidImageUrl)
    }
    
    func testInvalidImageUrlCodeNil() {
        self.forecast.code = nil
        
        XCTAssertEqual(self.forecast.imageUrl, "")
    }
    
    func testInvalidImageUrlCodeEmpty() {
        self.forecast.code = ""
        
        XCTAssertEqual(self.forecast.imageUrl, "")
    }
    
}
