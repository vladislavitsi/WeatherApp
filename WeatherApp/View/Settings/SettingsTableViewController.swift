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
        isDarkMode.setOn(themeManager.isDarkMode, animated: false)
        themeManager.isDarkModeProperty <~ isDarkMode.reactive.isOnValues
        bindToThemeManager()
    }
}

extension SettingsTableViewController: ThemeUpdateProtocol {
    func updateTheme() {
        cells.forEach { $0.backgroundColor = themeManager.get(color: .accent) }
        tableView.backgroundColor = themeManager.get(color: .backround)
        navigationController?.navigationBar.barStyle = themeManager.isDarkMode ? .black : .default
        textLabels.forEach { $0.textColor = themeManager.get(color: .text) }
    }
    
}


