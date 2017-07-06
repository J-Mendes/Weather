//
//  DateExtensionTests.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class DateExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Validators
    
    func testIsToday() {
        let date: Date = Date()
        XCTAssertTrue(date.isToday())
    }
    
    func testIsNotToday() {
        let date: Date = Date().addingTimeInterval(60 * 60 * 24)
        XCTAssertFalse(date.isToday())
    }
    
    func testIsTomorrow() {
        let date: Date = Date().addingTimeInterval(60 * 60 * 24)
        XCTAssertTrue(date.isTomorrow())
    }
    
    func testIsNotTomorrow() {
        let date: Date = Date()
        XCTAssertFalse(date.isTomorrow())
    }
    
    
    // MARK: - Converters
    
    func testWeekdayValue() {
        let weekday: String = Date().weekdayValue()
        XCTAssertTrue(weekday.characters.count > 0)
    }
    
    func testHourValue() {
        let hour: String = Date().hourFormat()
        XCTAssertTrue(hour.characters.count > 0 && hour.contains(":"))
    }
    
}
