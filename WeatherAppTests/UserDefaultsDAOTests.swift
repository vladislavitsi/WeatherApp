//
//  UserDefaultsDAOTests.swift
//  WeatherAppTests
//
//  Created by Uladzislau Kleshchanka on Aug/13/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import XCTest
@testable import WeatherApp

class UserDefaultsDAOTests: XCTestCase {
    
    var userDefaultsDAO = UserDefaultsDAO()
    fileprivate var mockUserDefault: UserDefaultsMock!
    
    override func setUp() {
        super.setUp()
        mockUserDefault = UserDefaultsMock()
        userDefaultsDAO.userDefaults = mockUserDefault
    }
    
    override func tearDown() {
        super.tearDown()
        mockUserDefault = nil
    }
    
    func testSetIsDarkTrue() {
        userDefaultsDAO.setObject(for: .darkMode(true))
        
        guard let isDarkMode = mockUserDefault.dict["darkMode"] as? Bool else {
            XCTFail("Expected bool value.")
            return
        }
        XCTAssertTrue(isDarkMode, "Expected isDarkMode is true.")
    }
    
    func testSetIsDarkModeFalse() {
        userDefaultsDAO.setObject(for: .darkMode(false))
        
        guard let isDarkMode = mockUserDefault.dict["darkMode"] as? Bool else {
            XCTFail("Expected bool value")
            return
        }
        XCTAssertFalse(isDarkMode, "Expected isDarkMode is false")
    }
    
    func testSetLat() {
        userDefaultsDAO.setObject(for: .lat(10.0))
        
        guard let lat = mockUserDefault.dict["lat"] as? Double else {
            XCTFail("Expected double value")
            return
        }
        XCTAssertEqual(lat, 10.0, "Expected lat is 10.0")
    }
    
    func testSetLon() {
        userDefaultsDAO.setObject(for: .lon(10.0))
        
        guard let lon = mockUserDefault.dict["lon"] as? Double else {
            XCTFail("Expected double value")
            return
        }
        XCTAssertEqual(lon, 10.0, "Expected lon is 10.0")
    }
    
    func testGetIsDarkModeTrue() {
        mockUserDefault.dict["darkMode"] = true
        
        let result = userDefaultsDAO.getObject(for: .darkMode)
        guard let isDarkMode = result as? Bool else {
            XCTFail("Expected bool value")
            return
        }
        
        XCTAssertTrue(isDarkMode, "Expected isDarkMode is true")
    }
    
    func testGetIsDarkModeFalse() {
        mockUserDefault.dict["darkMode"] = false
        
        let result = userDefaultsDAO.getObject(for: .darkMode)
        guard let isDarkMode = result as? Bool else {
            XCTFail("Expected bool value")
            return
        }
        
        XCTAssertFalse(isDarkMode, "Expected isDarkMode is false")
    }
    
    func testGetLat() {
        mockUserDefault.dict["lat"] = 10.0
        
        let result = userDefaultsDAO.getObject(for: .lat)
        guard let lat = result as? Double else {
            XCTFail("Expected double value")
            return
        }
        
        XCTAssertEqual(lat, 10.0, "Expected lat is 10.0")
    }
    
    func testGetLon() {
        mockUserDefault.dict["lon"] = 10.0
        
        let result = userDefaultsDAO.getObject(for: .lon)
        guard let lon = result as? Double else {
            XCTFail("Expected double value")
            return
        }
        
        XCTAssertEqual(lon, 10.0, "Expected lon is 10.0")
    }
    
}

fileprivate class UserDefaultsMock: UserDefaults {
    
    var dict = [String : Any]()
    
    override func object(forKey defaultName: String) -> Any? {
        return dict[defaultName]
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        dict[defaultName] = value
    }
    
}
