//
//  ThemeManager.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

final class ThemeManager {
    
    enum ThemeColor: Int {
        case text
        case accent
        case backround
        case tint
        
        private static let lightThemeColors = [UIColor(named: "color-text-lightMode")!,
                                               UIColor(named: "color-accent-lightMode")!,
                                               UIColor(named: "color-background-lightMode")!,
                                               UIColor(named: "color-tint-lightMode")!]
        
        private static let darkThemeColors = [UIColor(named: "color-text-darkMode")!,
                                              UIColor(named: "color-accent-darkMode")!,
                                              UIColor(named: "color-background-darkMode")!,
                                              UIColor(named: "color-tint-darkMode")!]
        
        func getColor(for darkMode: Bool) -> UIColor {
            return darkMode ? ThemeColor.darkThemeColors[self.rawValue] : ThemeColor.lightThemeColors[self.rawValue]
        }
    }
    
    static let shared = ThemeManager()
    
    let isDarkModeProperty = MutableProperty(UserDefaults.standard.object(forKey: AppDelegate.isDarkModeKey) as? Bool ?? false)
    
    var isDarkModeProducer: SignalProducer<Bool, NoError> {
        return isDarkModeProperty.producer
    }
    
    var isDarkMode: Bool {
        return isDarkModeProperty.value
    }
    
    func get(color: ThemeManager.ThemeColor) -> UIColor {
        return color.getColor(for: isDarkMode)
    }
    
    static func get(color: ThemeManager.ThemeColor, for isDark: Bool) -> UIColor {
        return color.getColor(for: isDark)
    }
    
    private init() {
        isDarkModeProperty.signal
            .observeValues { UserDefaults.standard.set($0, forKey: AppDelegate.isDarkModeKey) }
    }
}



