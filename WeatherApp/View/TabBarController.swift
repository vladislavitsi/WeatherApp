//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/08/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class TabBarController: UITabBarController, DarkThemeSupport {

    override func viewDidLoad() {
        super.viewDidLoad()
        themeManager.isDarkModeProducer
            .startWithValues { [weak self] isDarkMode in
            self?.tabBar.barStyle = isDarkMode ? .black : .default
        }
    }
}
