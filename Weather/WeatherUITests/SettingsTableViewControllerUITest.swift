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
        self.app.navigationBars.buttons["settings"].tap()
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    func testSettingsTitleExists() {
        let navigationBar: XCUIElement = self.app.navigationBars[TextUtils.localizedString("settings")]
        XCTAssert(navigationBar.exists)
    }
    
    func testTableViewHasCells() {
        XCTAssertTrue(self.app.tables.cells.count > 0)
    }
    
    func testLocationTitleExists() {
        let locationTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("location")]
        XCTAssert(locationTitle.exists)
    }
    
    func testUnitSectionTitleExists() {
        let unitTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("unit")]
        XCTAssert(unitTitle.exists)
    }
    
    func testImperialTitleExists() {
        let imperialTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("imperial")]
        XCTAssert(imperialTitle.exists)
    }
    
    func testMetricTitleExists() {
        let metricTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("metric")]
        XCTAssert(metricTitle.exists)
    }
    
    func testBackButtonExists() {
        let backButton: XCUIElement = self.app.navigationBars.buttons.element(boundBy: 0)
        XCTAssert(backButton.exists)
    }
    
    
    // MARK: Actions
    
    func testBackButton() {
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(self.app.navigationBars.staticTexts.count > 0)
    }
    
    func testImperialUnitsChange() {
        self.app.tables.staticTexts[TextUtils.localizedString("imperial")].tap()
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(3)
        
        let unitView: XCUIElement = self.app.tables.staticTexts["F"]
        XCTAssert(unitView.exists)
    }
    
    func testMetricUnitsChange() {
        self.app.tables.staticTexts[TextUtils.localizedString("metric")].tap()
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(3)
        
        let unitView: XCUIElement = self.app.tables.staticTexts["C"]
        XCTAssert(unitView.exists)
    }
    
    func testNavigateToLocation() {
        self.app.tables.staticTexts[TextUtils.localizedString("location")].tap()
        
        let navigationBar: XCUIElement = self.app.navigationBars[TextUtils.localizedString("location")]
        XCTAssert(navigationBar.exists)
    }
    
}
