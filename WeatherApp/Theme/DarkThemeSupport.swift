//
//  DarkThemeSupport.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation

protocol DarkThemeSupport {
    var themeManager: ThemeManager { get }
}

extension DarkThemeSupport {
    var themeManager: ThemeManager {
        return ConfigurationController.shared.themeManager
    }
}

protocol ThemeUpdateProtocol: class, DarkThemeSupport {
    func updateTheme()
    func bindToThemeManager()
}

extension ThemeUpdateProtocol {
    func bindToThemeManager() {
        themeManager.isDarkModeProducer
            .startWithValues { [weak self] _ in self?.updateTheme() }
    }
}
