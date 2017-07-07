//
//  NetworkServiceTests.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
import MapKit
@testable import Weather

class NetworkServiceTests: XCTestCase {
    
    fileprivate let validImage: String = "http://l.yimg.com/a/i/us/we/52/34.gif"
    fileprivate let validPlace: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.727537, longitude: -9.139263)
    fileprivate let invalidPlace: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    fileprivate var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        
        self.networkService = NetworkService()
    }
    
    override func tearDown() {
        self.networkService = nil
        
        super.tearDown()
    }
    
    internal func testInstance() {
        XCTAssertNotNil(self.networkService)
    }
    
    internal func testSessionInstance() {
        XCTAssertNotNil(self.networkService.session)
    }
    
    internal func testCancelRequests() {
        for _ in 0..<10 {
            self.networkService.getWeather(place: "", units: Constants.DefaultValues.defaultUnit, completion: {_,_ in })
        }
        
        let requestExpectation: XCTestExpectation = expectation(description: "cancelTasks")
        var initialTasks: Int = -1
        var endTasks: Int = -1
        
        self.networkService.session.getAllTasks { (allTasks: [URLSessionTask]) in
            initialTasks = allTasks.count
            
            self.networkService.cancelAllRequests(completion: {
                self.networkService.session.getAllTasks(completionHandler: { (tasks: [URLSessionTask]) in
                    endTasks = tasks.count
                    
                    requestExpectation.fulfill()
                })
            })
        }
        
        waitForExpectations(timeout: 10.0) { (error: Error?) in
            if error == nil {
                XCTAssertNotEqual(initialTasks, 0)
                XCTAssertEqual(endTasks, 0)
            } else {
                XCTFail()
            }
        }
    }
    
    
    // MARK: - Weather request
    
    internal func testWeatherRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherSuccess")
        
        self.networkService.getWeather(place: Constants.DefaultValues.defaultLocation, units: Constants.DefaultValues.defaultUnit) { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                XCTAssertTrue(data!.keys.contains("query"))
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testWeatherRequestFail() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherFail")
        
        self.networkService.getWeather(place: "", units: Constants.DefaultValues.defaultUnit) { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                XCTAssertTrue(data!.keys.contains("error"))
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    
    // MARK: - Place request
    
    internal func testPlaceRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "placeSuccess")
        
        self.networkService.getPlace(latitude: self.validPlace.latitude, longitude: self.validPlace.longitude) { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                XCTAssertTrue(data!.keys.contains("query"))
                XCTAssertTrue((data!["query"] as? [String: Any])!.keys.contains("results"))
                XCTAssertFalse((data!["query"] as? [String: Any])!["results"]! is NSNull)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testPlaceRequestFail() {
        let requestExpectation: XCTestExpectation = expectation(description: "placeFail")
        
        self.networkService.getPlace(latitude: self.invalidPlace.latitude, longitude: self.invalidPlace.longitude) { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                XCTAssertTrue(data!.keys.contains("query"))
                XCTAssertTrue((data!["query"] as? [String: Any])!.keys.contains("results"))
                XCTAssertTrue((data!["query"] as? [String: Any])!["results"]! is NSNull)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    
    // MARK: - Image request
    
    internal func testImageRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "imageSuccess")
        
        self.networkService.getImage(link: self.validImage) { (image: UIImage?, error: Error?) in
            if error == nil {
                XCTAssertNotNil(image)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testImageRequestFailure() {
        let requestExpectation: XCTestExpectation = expectation(description: "imageFail")
        
        self.networkService.getImage(link: "") { (image: UIImage?, error: Error?) in
            if error == nil {
                XCTAssertNil(image)
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
}
