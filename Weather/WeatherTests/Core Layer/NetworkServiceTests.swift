//
//  NetworkServiceTests.swift
//  Weather
//
//  Created by Jorge Mendes on 04/07/17.
//  Copyright © 2017 Jorge Mendes. All rights reserved.
//

import XCTest
@testable import Weather

class NetworkServiceTests: XCTestCase {
    
    fileprivate let validPlace: String = "Lisbon"
    
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
    
    internal func testWeatherRequestSuccess() {
        let requestExpectation: XCTestExpectation = expectation(description: "weatherSuccess")
        
        self.networkService.getWeather(place: self.validPlace) { (data: [String : Any]?, error: Error?) in
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
        
        self.networkService.getWeather(place: "") { (data: [String : Any]?, error: Error?) in
            if error == nil && data != nil {
                XCTAssertTrue(data!.keys.contains("error"))
            } else {
                XCTFail()
            }
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    internal func testCancelRequests() {
        for _ in 0..<10 {
            self.networkService.getWeather(place: "", completion: {_,_ in })
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
                XCTAssertEqual(initialTasks, 10)
                XCTAssertEqual(endTasks, 0)
            } else {
                XCTFail()
            }
        }
    }
    
}