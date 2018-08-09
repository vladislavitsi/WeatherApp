//
//  ConfigurationController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit

class ConfigurationController {
    static let shared = ConfigurationController()
    
    let themeManager: ThemeManager
    let persistanceData: PersistentDataProtocol
    
    init(_ persistanceData: PersistentDataProtocol = UserDefaultsDAO()) {
        self.persistanceData = persistanceData
        themeManager = ThemeManager(persistanceData)
    }
}
