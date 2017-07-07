//
//  WeatherTableViewControllerUITests.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest

class WeatherTableViewControllerUITests: XCTestCase {
    
    fileprivate var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launch()
        
        // give some time for data to load
        sleep(3)
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    func testDataFetch() {
        XCTAssertTrue(self.app.tables.cells.count > 0)
    }
    
    func testIfLocationTitleExists() {
        XCTAssertTrue(self.app.navigationBars.staticTexts.count > 0)
    }
    
    func testScrollBottom() {
        for i in 0..<(self.app.tables.cells.count - 3) {
            self.app.tables.children(matching: .cell).element(boundBy: i).swipeUp()
        }
    }
    
    func testScrollToTop() {
        for i in 0..<(self.app.tables.cells.count / 2) {
            self.app.tables.children(matching: .cell).element(boundBy: i).swipeUp()
        }
        self.app.statusBars.element.tap()
    }
    
}
