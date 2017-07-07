//
//  DataServiceTests.swift
//  Weather
//
//  Created by Jorge Mendes on 05/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
import MapKit
@testable import Weather

class DataServiceTests: XCTestCase {
    
    fileprivate let validPlace: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.727537, longitude: -9.139263)
    fileprivate let invalidPlace: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
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
    
    
    // MARK: - Weather data
    
    internal func testWeatherRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherSuccess")
        
        self.dataService.getWeather(place: Constants.DefaultValues.defaultLocation, units: Constants.DefaultValues.defaultUnit) { (weather: WeatherData?, error: Error?) in
            if error == nil {
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
        
        self.dataService.getWeather(place: "", units: Constants.DefaultValues.defaultUnit) { (weather: WeatherData?, error: Error?) in
            XCTAssertTrue(weather == nil && error == nil)
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testWeatherUnitsImperialSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherImperialUnits")
        
        self.dataService.getWeather(place: Constants.DefaultValues.defaultLocation, units: Constants.UnitsType.Imperial.rawValue) { (weather: WeatherData?, error: Error?) in
            if error == nil {
                XCTAssertNotNil(weather)
                XCTAssertEqual(weather?.units.temperature.lowercased(), "f")
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testWeatherUnitsMetricSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherMetricUnits")
        
        self.dataService.getWeather(place: Constants.DefaultValues.defaultLocation, units: Constants.UnitsType.Metric.rawValue) { (weather: WeatherData?, error: Error?) in
            if error == nil {
                XCTAssertNotNil(weather)
                XCTAssertEqual(weather?.units.temperature.lowercased(), "c")
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    
    // MARK: - Place request
    
    internal func testPlaceRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "placeSuccess")
        
        self.dataService.getPlace(latitude: self.validPlace.latitude, longitude: self.validPlace.longitude) { (place: String?, error: Error?) in
            if error == nil {
                XCTAssertNotNil(place)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testPlaceRequestFail() {
        let requestExpectation: XCTestExpectation = expectation(description: "placeFail")
        
        self.dataService.getPlace(latitude: self.invalidPlace.latitude, longitude: self.invalidPlace.longitude) { (place: String?, error: Error?) in
            if error == nil {
                XCTAssertNil(place)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}
