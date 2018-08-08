//
//  SettingsTableViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/07/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var units: UISegmentedControl!
    @IBOutlet weak var isDarkMode: UISwitch!
    
    @IBOutlet var textLabels: [UILabel]!
    @IBOutlet var cells: [UITableViewCell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isDarkMode.setOn(ThemeManager.shared.isDarkMode, animated: false)
        ThemeManager.shared.isDarkModeProperty <~ isDarkMode.reactive.isOnValues
        bindToThemeManager()
    }
}

extension SettingsTableViewController: DarkThemeSupport {
    func updateTheme() {
        cells.forEach { $0.backgroundColor = ThemeManager.shared.get(color: .accent) }
        tableView.backgroundColor = ThemeManager.shared.get(color: .backround)
        navigationController?.navigationBar.barStyle = ThemeManager.shared.isDarkMode ? .black : .default
        textLabels.forEach { $0.textColor = ThemeManager.shared.get(color: .text) }
    }
    
}


