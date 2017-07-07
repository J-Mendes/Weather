//
//  StringExtensionTests.swift
//  Weather
//
//  Created by Jorge Mendes on 06/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class StringExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Converters
    
    func testShortDateSuccess() {
        let shortDate: String = "4 Jul 2017"
        let date: Date? = shortDate.dateValueFromShortDate()
        XCTAssertNotNil(date)
    }
    
    func testShortDateFailure() {
        let shortDate: String = "4 July 2017 18:00"
        let date: Date? = shortDate.dateValueFromShortDate()
        XCTAssertNil(date)
    }
    
    func testHourDateSuccess() {
        let shortDate: String = "4:4 PM"
        let date: Date? = shortDate.dateValueFromHour()
        XCTAssertNotNil(date)
    }
    
    func testHourDateFailure() {
        let shortDate: String = "16:04"
        let date: Date? = shortDate.dateValueFromHour()
        XCTAssertNil(date)
    }
    
}
