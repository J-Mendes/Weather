//
//  DataServiceTests.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class DataServiceTests: XCTestCase {
    
    fileprivate let validPlace: String = "Lisbon"
    
    fileprivate var dataService: DataService!
    
    override func setUp() {
        super.setUp()
        
        self.dataService = DataService()
    }
    
    override func tearDown() {
        self.dataService = nil
        
        super.tearDown()
    }
    
    internal func testInstance() {
        XCTAssertNotNil(self.dataService)
    }
    
    internal func testNetworkInstance() {
        XCTAssertNotNil(self.dataService.networkService)
    }
    
    internal func testWeatherRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherSuccess")
        
        self.dataService.getWeather(place: validPlace) { (weather: WeatherData?, error: Error?) in
            if error == nil && weather != nil {
                XCTAssertNotNil(weather)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testWeatherRequestFail() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherFail")
        
        self.dataService.getWeather(place: "") { (weather: WeatherData?, error: Error?) in
            XCTAssertTrue(weather == nil && error == nil)
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}
