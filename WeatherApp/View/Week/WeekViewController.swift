//
//  WeekTableViewController.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/09/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class WeekViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    
    private let weekWeatherData = MutableProperty(WeekWeather())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekWeatherData.producer.startWithValues { [weak self] weekWeatherData in
            guard let strongSelf = self else { return }
            strongSelf.stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            weekWeatherData.list.forEach { weekWeatherData in
                let view = WeekWeatherViewCell()
                view.viewModel.value = weekWeatherData
                view.heightAnchor.constraint(equalToConstant: 90).isActive = true
                view.widthAnchor.constraint(equalTo: strongSelf.stack.widthAnchor, multiplier: 1)
                strongSelf.stack.addArrangedSubview(view)
            }
        }

        bindToThemeManager()
        updateData()
    }
    
    private func updateData() {
        let lat = String(ConfigurationController.shared.persistanceData.getObject(for: .lat) as? Double ?? 0.0)
        let lon = String(ConfigurationController.shared.persistanceData.getObject(for: .lon) as? Double ?? 0.0)
        WeatherNetworker.getData(for: .dailyWeather, arguments: lat, lon)
            .startWithValues { [weak self] weekWeatherData in
                self?.weekWeatherData.value = weekWeatherData
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
}

extension WeekViewController: ThemeUpdateProtocol {
    func updateTheme() {
        view.backgroundColor = themeManager.get(color: .backround)
        navigationController?.navigationBar.barStyle = themeManager.isDarkMode ? .black : .default
    }
    
}
