//
//  LocationMapViewControllerUITests.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest

class LocationMapViewControllerUITests: XCTestCase {
    
    fileprivate var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launch()
        
        self.app.navigationBars.buttons["settings"].tap()
        self.app.tables.staticTexts[TextUtils.localizedString("location")].tap()
        
        // give some time for data to load
        sleep(1)
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    func testSettingsTitleExists() {
        let navigationBar: XCUIElement = self.app.navigationBars[TextUtils.localizedString("location")]
        XCTAssert(navigationBar.exists)
    }
    
    func testHintTitleExists() {
        let hintTitle: XCUIElement = self.app.staticTexts[TextUtils.localizedString("map_description")]
        XCTAssert(hintTitle.exists)
    }
    
    func testLocationViewExists() {
        let locationView: XCUIElement = app.otherElements.containing(.navigationBar, identifier:TextUtils.localizedString("location")).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        XCTAssert(locationView.exists)
    }
    
    func testMapExists() {
        XCTAssert(self.app.maps.count > 0)
    }
    
    func testBackButtonExists() {
        let backButton: XCUIElement = self.app.navigationBars.buttons.element(boundBy: 0)
        XCTAssert(backButton.exists)
    }
    
    
    // Mark: Actions
    
    func testBackButton() {
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(self.app.navigationBars.staticTexts.count > 0)
    }
    
    func testLocationSet() {
        let map: XCUIElement = self.app.maps.element
        map.press(forDuration: 1.0);
        sleep(1)
        
        XCTAssert(map.exists)
    }
    
    func testLocationChange() {
        let map: XCUIElement = self.app.maps.element
        map.press(forDuration: 1.0);
        sleep(1)
        
        XCTAssert(map.exists)
        
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(3)
        
        XCTAssertTrue(self.app.navigationBars.staticTexts.count > 0)
    }
    
}
