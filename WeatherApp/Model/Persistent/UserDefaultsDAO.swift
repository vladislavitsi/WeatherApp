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

    init() {}
    
    func getObject(for persistentType: PersistentDataType) -> Any {
        guard let object = UserDefaults.standard.object(forKey: persistentType.rawValue) else {
            return persistentType.defaultValue
        }
        return object
    }
    
    func setObject(for persistentType: PersistentDataTypeWithData) {
        switch persistentType {
        case .darkMode(let isDarkMode):
            UserDefaults.standard.set(isDarkMode, forKey: PersistentDataType.darkMode.rawValue)
        case .lat(let lat):
            UserDefaults.standard.set(lat, forKey: PersistentDataType.lat.rawValue)
        case .lon(let lon):
            UserDefaults.standard.set(lon, forKey: PersistentDataType.lon.rawValue)
        }
    }
}
