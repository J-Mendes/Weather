//
//  ConditionModelTests.swift
//  Weather
//
//  Created by Jorge Mendes on 08/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class ConditionModelTests: XCTestCase {
    
    fileprivate let ValidImageUrl: String = "http://l.yimg.com/a/i/us/we/52/3.gif"
    
    fileprivate var condition: Condition!
    
    override func setUp() {
        super.setUp()
        
        self.condition = Condition()
    }
    
    override func tearDown() {
        self.condition = nil
        
        super.tearDown()
    }
    
    func testValidImageUrl() {
        self.condition.code = "3"
        
        XCTAssertEqual(self.condition.imageUrl, ValidImageUrl)
    }
    
    func testInvalidImageUrlCodeNil() {
        self.condition.code = nil
        
        XCTAssertEqual(self.condition.imageUrl, "")
    }
    
    func testInvalidImageUrlCodeEmpty() {
        self.condition.code = ""
        
        XCTAssertEqual(self.condition.imageUrl, "")
    }
    
}
