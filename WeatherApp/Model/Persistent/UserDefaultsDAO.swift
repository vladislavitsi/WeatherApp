//
//  UserDefaultsDAO.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

struct UserDefaultsDAO: PersistentDataProtocol {

    var userDefaults = UserDefaults.standard
    
    func getObject(for persistentType: PersistentDataType) -> Any {
        guard let object = userDefaults.object(forKey: persistentType.rawValue) else {
            return persistentType.defaultValue
        }
        return object
    }
    
    func setObject(for persistentType: PersistentDataTypeWithData) {
        switch persistentType {
        case .darkMode(let isDarkMode):
            userDefaults.set(isDarkMode, forKey: PersistentDataType.darkMode.rawValue)
        case .lat(let lat):
            userDefaults.set(lat, forKey: PersistentDataType.lat.rawValue)
        case .lon(let lon):
            userDefaults.set(lon, forKey: PersistentDataType.lon.rawValue)
        }
    }
}
