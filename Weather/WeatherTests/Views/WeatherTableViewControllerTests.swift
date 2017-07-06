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
        
        self.weatherViewController = ((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController as! UINavigationController).viewControllers.first as! WeatherTableViewController
    }
    
    override func tearDown() {
        self.weatherViewController = nil
        
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(self.weatherViewController)
    }
    
    func testDataServiceInjection() {
        XCTAssertNotNil(self.weatherViewController.dataService)
    }
    
}
