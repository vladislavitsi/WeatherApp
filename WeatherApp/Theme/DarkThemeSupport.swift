//
//  DarkThemeSupport.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import Foundation

protocol DarkThemeSupport: class {
    func updateTheme()
    func bindToThemeManager()
}

extension DarkThemeSupport {
    func bindToThemeManager() {
        ThemeManager.shared.isDarkModeProducer
            .startWithValues { [weak self] _ in self?.updateTheme() }

    }
}
