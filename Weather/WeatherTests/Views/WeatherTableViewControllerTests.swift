//
//  WeatherTableViewControllerTests.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTableViewControllerTests: XCTestCase {
    
    fileprivate var weatherViewController: WeatherTableViewController!
    
    override func setUp() {
        super.setUp()
        
        self.weatherViewController = WeatherTableViewController()
        self.weatherViewController.dataService = DataService()
    }
    
    override func tearDown() {
        self.weatherViewController = nil
        
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(self.weatherViewController)
    }
    
    func testDataServiceInstance() {
        XCTAssertNotNil(self.weatherViewController.dataService)
    }
    
}
