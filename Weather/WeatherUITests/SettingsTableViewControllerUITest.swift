//
//  SettingsTableViewControllerUITest.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest

class SettingsTableViewControllerUITest: XCTestCase {
    
    fileprivate var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launch()
        
        // give some time for data to load
        sleep(3)
        XCUIApplication().navigationBars.buttons["settings"].tap()
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    func testUnitsChange() {
        app.tables.staticTexts["Imperial"].tap()
    }
    
}
