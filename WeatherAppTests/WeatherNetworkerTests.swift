//
//  WeatherNetworkerTests.swift
//  WeatherAppTests
//
//  Created by Uladzislau Kleshchanka on Aug/13/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import XCTest

@testable import WeatherApp

class WeatherNetworkerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetDataWithCityName() {
        let exp = expectation(description: "City name is Moscow")
        WeatherNetworker.getData(for: .urlWithCityName, arguments: "Moscow").startWithValues { (weatherData: WeatherData) in
            if weatherData.city == "Moscow" {
                exp.fulfill()
            } else {
                XCTFail("Wrong city name")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetDataWithCoordinates() {
        let moscowLat = 55.75
        let moscowLon = 37.62
        let exp = expectation(description: "City name is Moscow")
        WeatherNetworker.getData(for: .urlWithCoordinates, arguments: moscowLat, moscowLon).startWithValues { (weatherData: WeatherData) in
            print(weatherData)
            if weatherData.city == "Moscow" {
                exp.fulfill()
            } else {
                XCTFail("Wrong city name")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
