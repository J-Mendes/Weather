//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    fileprivate var appDelegate: AppDelegate!
    
    override func setUp() {
        super.setUp()
        
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    override func tearDown() {
        self.appDelegate = nil
        
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(self.appDelegate)
    }
    
    func testWindowInstance() {
        XCTAssertNotNil(self.appDelegate.window)
    }
    
    func testRootViewControllerInstance() {
        XCTAssertNotNil(self.appDelegate.window?.rootViewController)
    }
    
    func testRootViewControllerType() {
        XCTAssertTrue(self.appDelegate.window?.rootViewController is UINavigationController)
    }
    
    func testWeatherViewControllerInstance() {
        XCTAssertNotNil((self.appDelegate.window?.rootViewController as! UINavigationController).viewControllers.first)
    }
    
    func testWeatherViewControllerType() {
        XCTAssertTrue((self.appDelegate.window?.rootViewController as! UINavigationController).viewControllers.first is WeatherTableViewController)
    }
    
}
