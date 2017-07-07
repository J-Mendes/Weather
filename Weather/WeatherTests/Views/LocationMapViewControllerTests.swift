//
//  LocationMapViewControllerTests.swift
//  Weather
//
//  Created by Jorge Mendes on 07/07/2017.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class LocationMapViewControllerTests: XCTestCase {
    
    fileprivate var locationViewController: LocationMapViewController!
    
    override func setUp() {
        super.setUp()
            
        self.locationViewController = LocationMapViewController()
        self.locationViewController.dataService = DataService()
        self.locationViewController.currentLocation = Constants.DefaultValues.defaultLocation
    }
    
    override func tearDown() {
        self.locationViewController = nil
        
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(self.locationViewController)
    }
    
    func testDataServiceInstance() {
        XCTAssertNotNil(self.locationViewController.dataService)
    }
    
    func testCurrentLocationInstance() {
        XCTAssertNotNil(self.locationViewController.currentLocation)
    }
    
    func testCurrentLocationInjection() {
        XCTAssertEqual(self.locationViewController.currentLocation, Constants.DefaultValues.defaultLocation)
    }
    
}
