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
    
    func testLocationTitleExists() {
        XCTAssertTrue(self.app.navigationBars.staticTexts.count > 0)
    }
    
    func testTableViewHasCells() {
        XCTAssertTrue(self.app.tables.cells.count > 0)
    }
    
    func testDetailsSectionTitleExists() {
        let detailTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("details")]
        XCTAssert(detailTitle.exists)
    }
    
    func testHumidityTitleExists() {
        let humidityTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("humidity")]
        XCTAssert(humidityTitle.exists)
    }
    
    func testVisibilityTitleExists() {
        let visibilityTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("visibility")]
        XCTAssert(visibilityTitle.exists)
    }
    
    func testWindSpeedTitleExists() {
        let windSpeedTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("wind")]
        XCTAssert(windSpeedTitle.exists)
    }
    
    func testSunriseTitleExists() {
        let sunriseTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("sunrise")]
        XCTAssert(sunriseTitle.exists)
    }
    
    func testSunsetTitleExists() {
        let sunsetTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("sunset")]
        XCTAssert(sunsetTitle.exists)
    }
    
    func testForecastSectionTitleExists() {
        let forecastTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("forecast")]
        XCTAssert(forecastTitle.exists)
    }
    
    func testForecastTomorrowTitleExists() {
        let tomorrowTitle: XCUIElement = self.app.tables.staticTexts[TextUtils.localizedString("tomorrow")]
        XCTAssert(tomorrowTitle.exists)
    }
    
    func testErrorViewDontExists() {
        let errorView: XCUIElement = self.app.tables["\(TextUtils.localizedString("pull_refresh")), \(TextUtils.localizedString("error_generic"))"]
        XCTAssertFalse(errorView.exists)
    }
    
    func testSettingsButtonExists() {
        let settingsButton: XCUIElement = self.app.navigationBars.buttons["settings"]
        XCTAssert(settingsButton.exists)
    }
    
    
    // MARK: Actions
    
    func testPullToRefresh() {
        let firstCell: XCUIElement = self.app.tables.children(matching: .cell).element(boundBy: 0)
        
        let start: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
    func testScrollBottom() {
        let firstCell: XCUIElement = self.app.tables.children(matching: .cell).element(boundBy: 0)
        let lastCell: XCUIElement = self.app.tables.children(matching: .cell).element(boundBy: self.app.tables.cells.count - 1)
        
        let start: XCUICoordinate = lastCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 60))
        let finish: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
    func testScrollToTop() {
        let firstCell: XCUIElement = self.app.tables.children(matching: .cell).element(boundBy: 0)
        let lastCell: XCUIElement = self.app.tables.children(matching: .cell).element(boundBy: self.app.tables.cells.count - 1)
        
        let start: XCUICoordinate = lastCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        let finish: XCUICoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        start.press(forDuration: 0, thenDragTo: finish)
        
        self.app.statusBars.element.tap()
    }
    
    func testNavigateToSettings() {
        self.app.navigationBars.buttons["settings"].tap()
        
        let navigationBar: XCUIElement = self.app.navigationBars[TextUtils.localizedString("settings")]
        XCTAssert(navigationBar.exists)
    }
    
}
