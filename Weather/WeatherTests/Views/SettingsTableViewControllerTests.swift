//
//  SettingsTableViewControllerTests.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsTableViewControllerTests: XCTestCase {
    
    fileprivate var settingsViewController: SettingsTableViewController!
    
    override func setUp() {
        super.setUp()
        
        self.settingsViewController = SettingsTableViewController()
        self.settingsViewController.currentLocation = Constants.DefaultValues.defaultLocation
        self.settingsViewController.currentUnit = Constants.DefaultValues.defaultUnit
    }
    
    override func tearDown() {
        self.settingsViewController = nil
        
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(self.settingsViewController)
    }
    
    func testCurrentLocationInstance() {
        XCTAssertNotNil(self.settingsViewController.currentLocation)
    }
    
    func testCurrentLocationInjection() {
        XCTAssertEqual(self.settingsViewController.currentLocation, Constants.DefaultValues.defaultLocation)
    }
    
    func testCurrentUnitInstance() {
        XCTAssertNotNil(self.settingsViewController.currentUnit)
    }
    
    func testCurrentUnitInjection() {
        XCTAssertEqual(self.settingsViewController.currentUnit, Constants.DefaultValues.defaultUnit)
    }
    
}
