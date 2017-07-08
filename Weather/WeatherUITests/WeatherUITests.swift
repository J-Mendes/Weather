//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {
    
    fileprivate var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    func testAppBackgroundCoverView() {
        XCUIDevice.shared().press(.home)
        self.app.launch()
        
        XCTAssertTrue(self.app.windows.element(boundBy: 0).exists)
    }
    
}
