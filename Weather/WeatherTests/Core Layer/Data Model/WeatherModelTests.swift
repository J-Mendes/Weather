//
//  WeatherModelTests.swift
//  Weather
//
//  Created by Jorge Mendes on 08/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherModelTests: XCTestCase {
    
    fileprivate var weather: Weather!
    
    override func setUp() {
        super.setUp()
        
        self.weather = Weather()
    }
    
    override func tearDown() {
        self.weather = nil
        
        super.tearDown()
    }
    
    func testTodayForecastSuccess() {
        var forecasts: [Forecast] = []
        for i in 0..<5 {
            var forecast = Forecast()
            forecast.date = Date().addingTimeInterval(TimeInterval(i * 24 * 60 * 60))
            forecasts.append(forecast)
        }
        self.weather.forecast = forecasts
        
        XCTAssertNotNil(self.weather.todayForecast)
    }
    
    func testTodayForecastFail() {
        var forecasts: [Forecast] = []
        for i in 1..<6 {
            var forecast = Forecast()
            forecast.date = Date().addingTimeInterval(TimeInterval(i * 24 * 60 * 60))
            forecasts.append(forecast)
        }
        self.weather.forecast = forecasts
        
        XCTAssertNil(self.weather.todayForecast)
    }
    
    func testForecastsSuccess() {
        var forecasts: [Forecast] = []
        for i in 0..<5 {
            var forecast = Forecast()
            forecast.date = Date().addingTimeInterval(TimeInterval(i * 24 * 60 * 60))
            forecasts.append(forecast)
        }
        self.weather.forecast = forecasts
        
        XCTAssertEqual(self.weather.forecastPrevisions.count, 4)
    }
    
}
