//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/02/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SearchTableViewCell: UITableViewCell, DarkThemeSupport {
    
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!

    let viewModel = MutableProperty(SearchWeatherData())
    
    func bindViewModel () {
        cityAndCountry.reactive.text <~ viewModel.signal.map { "\($0.city), \($0.country)" }
        weatherDescription.reactive.text <~ viewModel.signal.map { $0.weatherDescription }
        temperature.reactive.text <~ viewModel.signal.map { $0.temperature + "°" }
        imageIcon.reactive.image <~ viewModel.map { $0.icon }
        
        reactive.backgroundColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .accent, for: $0) }
        temperature.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .text, for: $0) }
        temperature.reactive.backgroundColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .accent, for: $0) }
        cityAndCountry.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .text, for: $0) }
        weatherDescription.reactive.textColor <~ themeManager.isDarkModeProducer.map { ThemeManager.get(color: .text, for: $0) }

    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bindViewModel()
    }
    
    override func prepareForReuse() {
        cityAndCountry.text = ""
        weatherDescription.text = ""
        temperature.text = ""
        imageIcon.image = nil
    }

}
