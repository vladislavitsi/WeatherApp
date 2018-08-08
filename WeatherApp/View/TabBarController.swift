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

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeManager.shared.isDarkModeProducer
            .startWithValues {
            self.tabBar.barStyle = $0 ? .black : .default
        }
    }
}
